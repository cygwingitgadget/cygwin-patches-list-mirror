Return-Path: <cygwin-patches-return-5105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24039 invoked by alias); 31 Oct 2004 11:31:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24029 invoked from network); 31 Oct 2004 11:31:45 -0000
Received: from unknown (HELO smartmx-07.inode.at) (213.229.60.39)
  by sourceware.org with SMTP; 31 Oct 2004 11:31:45 -0000
Received: from [62.99.252.218] (port=62751 helo=[192.168.0.2])
	by smartmx-07.inode.at with esmtp (Exim 4.30)
	id 1CODvx-0007lR-VO
	for cygwin-patches@cygwin.com; Sun, 31 Oct 2004 12:31:42 +0100
Message-ID: <4184CD1A.8070403@x-ray.at>
Date: Sun, 31 Oct 2004 11:31:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a3) Gecko/20040817
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] unlink
References: <4182BDCF.3C04BAF8@phumblet.no-ip.org> <4182BDCF.3C04BAF8@phumblet.no-ip.org> <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
In-Reply-To: <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
Content-Type: multipart/mixed;
 boundary="------------000800090200040201070605"
X-SW-Source: 2004-q4/txt/msg00106.txt.bz2

This is a multi-part message in MIME format.
--------------000800090200040201070605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 697

Pierre A. Humblet schrieb:
>>>It works on normal files. I haven't tested with the
>>>special names because I forgot how to create them !
>>>Feedback welcome.

works fine on w2k.
attached is a test to create such files.
unlink works fine on these.

didn't test with wchar and unicode files yet, just char.
but coreutils/findutils don't work with unicode files anyway.
(just testing findutils-4.1.20)

>>On reflection, however, wouldn't it be a little easier just to prepend
>>the path being deleted with a: \\.\ so that "rm nul" would eventually
>>translate to DeleteFile("\\.\c:\foo\null") (I'm not using true C
>>backslash quoting here)?  I don't know if that would work on Windows 9x,
>>though.

--------------000800090200040201070605
Content-Type: text/plain;
 name="testcreate.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testcreate.cc"
Content-length: 2562

// c++ -I../src/winsup/cygwin -o testcreate testcreate.cc -lntdll 
#include "winsup.h"
#include <stdio.h>
#include <ntdef.h>
#include "ntdll.h"

//#define NTCREATE
#undef NTCREATE

NTSTATUS 
  NtCreateDirectoryObject(
    OUT PHANDLE  DirectoryHandle,
    IN ACCESS_MASK  DesiredAccess,
    IN POBJECT_ATTRIBUTES  ObjectAttributes
    );

#ifndef NTCREATE
static HANDLE
create (char *path)
{
  HANDLE hFile; 
  char pwd[CYG_MAX_PATH], dev[CYG_MAX_PATH];
  int len;

  //create ("\\\\.\\c:\\con");
  if (len = GetCurrentDirectoryA (CYG_MAX_PATH, pwd)) {
    strcpy(dev, "\\\\.\\");
    strcat(dev, pwd);
    strcat(dev, "\\");
    strcat(dev, path);
  }
  hFile = CreateFile(dev,     // file to create
		     GENERIC_WRITE,          // open for writing
		     0,                      // do not share
		     NULL,                   // default security
		     CREATE_ALWAYS,          // overwrite existing
		     FILE_ATTRIBUTE_NORMAL | // normal file
		     FILE_FLAG_OVERLAPPED,   // asynchronous I/O
		     NULL);                  // no attr. template
  if (hFile == INVALID_HANDLE_VALUE) return 0;
  printf("%s created\n", path);
  CloseHandle(hFile);
  return hFile;
}

#else
static HANDLE
nt_create (WCHAR *wpath)
{
  WCHAR pwd[2*CYG_MAX_PATH];
  UNICODE_STRING upath = {0, sizeof (wpath), wpath};
  //UNICODE_STRING cpath = {0, 2, L"."};

  int len;
  HANDLE x, root = NULL;
  OBJECT_ATTRIBUTES attr;
  IO_STATUS_BLOCK io;
  NTSTATUS status;
  
  if (len = GetCurrentDirectoryW (2*CYG_MAX_PATH, pwd)) {
    UNICODE_STRING upwd = {0, sizeof (pwd), pwd};
    InitializeObjectAttributes (&attr, &upwd, OBJ_CASE_INSENSITIVE, NULL, NULL);
    NtOpenFile(&root, STANDARD_RIGHTS_ALL, &attr, &io, 0, 0);
  }
  InitializeObjectAttributes (&attr, &upath, OBJ_CASE_INSENSITIVE, root, NULL);
  // http://msdn.microsoft.com/library/default.asp?url=/library/en-us/devnotes/winprog/ntcreatefile.asp
  status = NtCreateFile (&x, STANDARD_RIGHTS_ALL, &attr, &io, NULL, FILE_ATTRIBUTE_NORMAL, 
                         FILE_SHARE_READ, FILE_OPEN, FILE_DELETE_ON_CLOSE, NULL, 0);
  if (!NT_SUCCESS (status))
    {
      printf("error creating %ls\n", wpath);
      return 0;
    }
  else {
    CloseHandle(x);
    return x;
  }
}
#endif

int main(int argc, char** argv)
{
#ifndef NTCREATE
  create ("con");
  create ("com");
  create ("nul");
  create ("aux");
  create ("prn");
  create ("lpt1");
  create ("...");
#else
  nt_create (L"con");
  nt_create (L"nul");
  nt_create (L"aux");
  nt_create (L"prn");
  nt_create (L"lpt1");
  nt_create (L"...");
#endif
  return(0);
}

--------------000800090200040201070605--
