//
//  main.swift
//  shlink
//
//  Created by Detlef Schneider on 23.04.15.
//  Copyright (c) 2015-2016 Schneider-Zone. All rights reserved.
//
// Tool to create hardlinks of folders

import Foundation

// Get my own process information
let myProcess = NSProcessInfo()

if (myProcess.arguments.count < 2)
{
	// Print syntax information, if not enough command line arguments
	print("Usage 1:\t\(myProcess.processName) [source] [target]")
	print("\t\thard-links the source directory to the target.\n")
	print("Usage 2:\t\(myProcess.processName) [-u] [target]")
	print("\t\tunlinks the target directory.")
	exit (1)
}
else
{
	// Parse command line arguments
	let arg1: String = myProcess.arguments[1]
	var ret : Int32
	
	if (arg1 == "-u")
	{
		// Unlink option
		let arg_trg: String = myProcess.arguments[2] 
		
		print("Unlinking \(arg_trg).")
		ret = unlink(arg_trg)
	}
	else
	{
		// Source and target given
		let arg_src: String = myProcess.arguments[1] 
		let arg_trg: String = myProcess.arguments[2] 
		
		print("Linking \(arg_src) to \(arg_trg).")
		ret = link(arg_src, arg_trg)
	}
	
	if (ret != 0)
	{
		// Print error string is error happened
		perror(myProcess.processName)
	}
	
	// leave with return code
	exit(ret)
}