Return-Path: <cygwin-patches-return-3430-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23291 invoked by alias); 21 Jan 2003 09:13:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23234 invoked from network); 21 Jan 2003 09:13:32 -0000
Message-ID: <3E2D101A.9090607@21cn.com>
Date: Tue, 21 Jan 2003 09:13:00 -0000
From: David Huang <hzhr@21cn.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; zh-CN; rv:1.2.1) Gecko/20021130
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: dlfcn.cc: clear previous dl errors before new dlopen, dlsym, dlclose
 call?
Content-Type: multipart/mixed;
 boundary="------------010903060008030200000101"
X-SW-Source: 2003-q1/txt/msg00079.txt.bz2

This is a multi-part message in MIME format.
--------------010903060008030200000101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 639

Hi!
Is't needed to clear previous dl errors before new dlopen, dlsym, dlclose call?
See attach test programs.

$ gcc -shared -o demo.dll demo.c
$ gcc -shared -o demo2.dll demo2.c
$ gcc -o test test.c
$ ./test
Output:
handle = f20000
dlsym init_plugin fail
init_plugin = 0
handle2 = f20000
dlsym init_plugin fail
init_plugin = f21050

I think output maybe like these:
handle = f20000
dlsym init_plugin fail
init_plugin = 0
handle2 = f20000
init_plugin = f21050

Is it so?

Thanks.

2003-01-21  David Huang  <davehzhr@hotmail.com>

	* dlfcn.cc: Add clear_dl_error.
	(dlopen): Clear previous dl error.
	(dlsym): Ditto.
	(dlclose): Ditto.





--------------010903060008030200000101
Content-Type: text/plain;
 name="dlfcn.cc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dlfcn.cc.patch"
Content-length: 1410

Index: dlfcn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dlfcn.cc,v
retrieving revision 1.17
diff -u -p -r1.17 dlfcn.cc
--- dlfcn.cc	31 Oct 2001 00:55:32 -0000	1.17
+++ dlfcn.cc	21 Jan 2003 09:08:39 -0000
@@ -1,6 +1,6 @@
 /* dlfcn.cc
 
-   Copyright 1998, 2000, 2001 Red Hat, Inc.
+   Copyright 1998, 2000, 2001, 2003 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -32,6 +32,12 @@ set_dl_error (const char *str)
   _dl_error = 1;
 }
 
+static void __stdcall
+clear_dl_error ()
+{
+  _dl_error = 0;
+}
+
 /* Look for an executable file given the name and the environment
    variable to use for searching (eg., PATH); returns the full
    pathname (static buffer) if found or NULL if not. */
@@ -89,6 +95,8 @@ dlopen (const char *name, int)
 
   void *ret;
 
+  clear_dl_error();
+
   if (name == NULL)
     ret = (void *) GetModuleHandle (NULL); /* handle for the current module */
   else
@@ -117,6 +125,8 @@ dlopen (const char *name, int)
 void *
 dlsym (void *handle, const char *name)
 {
+  clear_dl_error();
+
   void *ret = (void *) GetProcAddress ((HMODULE) handle, name);
   if (!ret)
     set_dl_error ("dlsym");
@@ -128,6 +138,8 @@ int
 dlclose (void *handle)
 {
   SetResourceLock (LOCK_DLL_LIST, READ_LOCK | WRITE_LOCK, "dlclose");
+
+  clear_dl_error();
 
   int ret = -1;
   void *temphandle = (void *) GetModuleHandle (NULL);


--------------010903060008030200000101
Content-Type: text/plain;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"
Content-length: 908

#include <stdio.h>
#include <dlfcn.h>

void main()
{
	char plugin_name[256] = "demo.dll";
	char plugin_name2[256] = "demo2.dll";
	void *handle, *handle2;
	void *(*init_plugin)();
	char *error;

	handle = dlopen(plugin_name, RTLD_NOW);
	if (!handle) {
		printf("dlopen fail\n");
//		return;
	} 
	printf("handle = %x\n", handle);
	init_plugin = dlsym(handle, "init_plugin");
	if ((error = dlerror()) != NULL) {
		printf("dlsym init_plugin fail\n");
//		dlclose(handle);
//		return;
	}
	printf("init_plugin = %x\n", init_plugin);
	dlclose(handle);

	handle2 = dlopen(plugin_name2, RTLD_NOW);
	if (!handle2) {
		printf("dlopen fail\n");
//		return;
	}
	printf("handle2 = %x\n", handle2);
	init_plugin = dlsym(handle2, "init_plugin");
	if ((error = dlerror()) != NULL) {
		printf("dlsym init_plugin fail\n");
//		dlclose(handle);
//		return;
	}
	printf("init_plugin = %x\n", init_plugin);

	dlclose(handle2);
}



--------------010903060008030200000101
Content-Type: text/plain;
 name="demo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="demo.c"
Content-length: 26

void no_init_plugin()
{}


--------------010903060008030200000101
Content-Type: text/plain;
 name="demo2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="demo2.c"
Content-length: 23

void init_plugin()
{}


--------------010903060008030200000101--
