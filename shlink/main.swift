//
//  main.swift
//  shlink
//
//  Created by Detlef Schneider on 23.04.15.
//  Copyright (c) 2015 Schneider-Zone. All rights reserved.
//
// Tool to create hardlinks of folders

import Foundation

// Get my own process information
let myProcess = NSProcessInfo()

if (myProcess.arguments.count < 2)
{
	// Print syntax information, if not enough command line arguments
	println("Usage 1:\t\(myProcess.processName) [source] [target]")
	println("\t\thard-links the source directory to the target.\n")
	println("Usage 2:\t\(myProcess.processName) [-u] [target]")
	println("\t\tunlinks the target directory.")
	exit (1)
}
else
{
	// Parse command line arguments
	let arg1: String = myProcess.arguments[1] as! String
	var ret : Int32
	
	if (arg1 == "-u")
	{
		// Unlink option
		let arg_trg: String = myProcess.arguments[2] as! String
		
		println("Unlinking \(arg_trg).")
		ret = unlink(arg_trg)
	}
	else
	{
		// Source and target given
		let arg_src: String = myProcess.arguments[1] as! String
		let arg_trg: String = myProcess.arguments[2] as! String
		
		println("Linking \(arg_src) to \(arg_trg).")
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