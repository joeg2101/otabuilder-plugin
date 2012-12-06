#Jesly Varghese 2012

#Part of OTA-Builder and Uploader Plugin For iOS Project
#Developed as a part of CI-Project @ Sourcebits LLC

#FTP Module
#This class deals with the upload of ipa, manifest and icon to remote ftp server
#Improvement needed, support for SFTP, Upload to dropbox, or using dropbox as ipa host is 
#a viable option

require 'rubygems'
require 'net/ftp'

module FTP
  def self.upload(hostname,username,pass,upload_path,project,build_number,files)
    ftp = Net::FTP.new
    ftp.passive = true
    ftp.connect hostname
    ftp.login username, pass
    ftp.chdir upload_path
    
    dir_contents = ftp.nlst
    ftp.mkdir project unless dir_contents.include? project
    
    ftp.chdir project
    ftp.mkdir build_number
    ftp.chdir build_number
    
    files.each do |file| 
       begin
        ftp.putbinaryfile file, File.basename(file)  
       rescue
        next
       end
    end
    
    ftp.quit
  end
end
