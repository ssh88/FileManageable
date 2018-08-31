//
//  FileManageable.swift
//  Desert Monkey
//
//  Created by Hussain, Shabeer (UK - London) on 02/03/2016.
//  Copyright © 2016 Desert Monkey. All rights reserved.
//

import UIKit

public protocol FileManageable {}

extension FileManageable {
    
    //MARK:- File Management
    
    public func fileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    public func deleteFile(at path: String) -> Bool {
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    //MARK:- Paths
    
    public func documentsDirectoryPath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath
    }
    
    public func documentsDirectoryURL() -> URL {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(string: documentsPath)!
    }
    
    
    public func allFiles(in directoryPath: String) -> [String]? {
        do {
            let fileNames = try FileManager.default.contentsOfDirectory(atPath: directoryPath)
            return fileNames
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    public func path(forFolder folderName: String, in directory: URL = URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])!, createIfNotFound: Bool = false) -> URL? {
        
        //firsts construct the file path
        let folderPath = directory.appendingPathComponent(folderName)
        
        //next we check if the folder needs to be creaded
        let fileManager = FileManager.default
        var directoryExists : ObjCBool = false
        if fileManager.fileExists(atPath: folderPath.path, isDirectory:&directoryExists) {
            if directoryExists.boolValue {
                //if it already exists, return it
                return folderPath
            }
        } else {
            
            if createIfNotFound {
                
                do {
                    try FileManager.default.createDirectory(atPath: folderPath.path, withIntermediateDirectories: true, attributes: nil)
                    return folderPath
                } catch {
                    debugPrint("FileManageable: \(error.localizedDescription)")
                }
            }
        }
        
        return nil
    }
    
    public func filePath(forFileName fileName: String, fileExtension: String, in directory: String) -> String? {
        return "\(directory)/\(fileName)/\(fileExtension)"
    }
    
    public func createFile(with fileName:String, fileExtension: String, in directory: String) -> Bool {
        
        guard let path = filePath(forFileName: fileName, fileExtension: fileExtension, in: directory) else { return false }
        return FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
    
    public func createFolder(withName folderName: String, in directory: URL) -> Bool {
        
        let folderPath = directory.appendingPathComponent(folderName)
        
        var directoryExists : ObjCBool = false
        if FileManager.default.fileExists(atPath: folderPath.path, isDirectory:&directoryExists) {
            if directoryExists.boolValue {
                //return true as it already exists
                return true
            }
        }
        
        do {
            try FileManager.default.createDirectory(atPath: folderPath.path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            debugPrint("FileManageable: \(error.localizedDescription)")
        }
        
        return false
    }
    
    //MARK:- File Info
    
    
    /**
     Calculates the total size of a directory
     
     - parameter directoryPath: The path of the directory to calculate the size of
     - returns: A string formatted file size of the directory
     */
    public func totalSize(ofDirectory directoryPath: String) -> String? {
        
        var directorySize: Int64 = 0
        guard let allFiles = self.allFiles(in: directoryPath) else { return nil }
        
        for fileName in allFiles {
            let filePath = directoryPath + "/" + fileName
            guard let fileSize = fileSize(for: filePath) else { continue }
            directorySize += fileSize.int64Value
        }
        
        let fileSizeString = ByteCountFormatter.string(fromByteCount: directorySize, countStyle: .file)
        return fileSizeString
    }
    
    /**
     Formatted file size for file at a given file path
     */
    public func formattedFileSize(for fileName: String, filePath: String) -> String? {
        
        guard let fileSize =  fileSize(for: filePath) else { return nil }
        let fileSizeString = ByteCountFormatter.string(fromByteCount: fileSize.int64Value, countStyle: .file)
        return fileSizeString
    }
    
    /**
     Calculates the size of a file at a given file path
     
     - parameter filePath: The path of the file
     - returns: The raw file size as a number
     */
    public func fileSize(for filePath: String) -> NSNumber? {
        
        do {
            return  try FileManager.default.attributesOfItem(atPath: filePath)[FileAttributeKey.size] as? NSNumber
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    /**
     Gets the file
     */
    public func `extension`(forFileAt filePath: URL) -> String? {
        
        let components = URLComponents(url: filePath, resolvingAgainstBaseURL: true)
        guard let fileExtension = components?.url?.pathComponents.last?.components(separatedBy: ".").last else {
            return nil
        }
        
        return ".\(fileExtension)"
    }
}
