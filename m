Return-Path: <cygwin-patches-return-4743-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31904 invoked by alias); 13 May 2004 18:09:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31885 invoked from network); 13 May 2004 18:09:37 -0000
X-Originating-IP: [4.18.151.35]
X-Originating-Email: [yjfwhhvvvhzk6wdy@hotmail.com]
X-Sender: yjfwhhvvvhzk6wdy@hotmail.com
From: "Stephen Cleary" <yjfwhhvvvhzk6wdy@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Strange problem with Cygwin from CVS
Date: Thu, 13 May 2004 18:09:00 -0000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3fec_693a_529c"
Message-ID: <BAY9-F14904H3Nztw4500030904@hotmail.com>
X-OriginalArrivalTime: 13 May 2004 18:09:37.0062 (UTC) FILETIME=[73A6BC60:01C43915]
X-SW-Source: 2004-q2/txt/msg00095.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_3fec_693a_529c
Content-Type: text/plain; format=flowed
Content-length: 1327

Hello everyone,

Sorry if this is OT; I'm not on the developer's mailing list.

I was finishing up my patch last night, and did an update/merge with the 
current CVS, and ran into a problem: bash now causes an access violation on 
startup.

So, I backed out my patch, and was just compiling the Cygwin CVS, and got 
the same thing. I tried it again at lunch today (thinking that someone may 
have committed something incorrectly and it would soon be fixed) - same 
problem. Is anyone else seeing this?

Here's what I'm doing:
[from /cygdrive/c/cygwin-cvs] cvs update -C
[from /cygdrive/c/cygwin-cvs/obj] make
[using a .cmd file] move the new-cygwin1.dll over c:\cygwin\bin\cygwin1.dll, 
also delete the generated cygwin0.dll

After this procedure, starting bash will display the following in the 
console:
      4 [main] bash 320 handle_exceptions: Exception: 
STATUS_ACCESS_VIOLATION
   1059 [main] bash 320 open_stackdumpfile: Dumping stack trace to 
bash.exe.stackdump

I'm attaching the stackdump file if that's any help.

So, my main question is: is anyone else seeing this, or has something on my 
machine gotten screwed up?

        -Steve

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar  get it now! 
http://toolbar.msn.com/go/onm00200415ave/direct/01/

------=_NextPart_000_3fec_693a_529c
Content-Type: text/plain; name="bash_exe.stackdump.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="bash_exe.stackdump.txt"
Content-length: 1048

Exception: STATUS_ACCESS_VIOLATION at eip=61098E82
eax=0000063C ebx=00000000 ecx=00000000 edx=FFFFFFFF esi=61068C3F 
edi=FFFFFFFF
ebp=0022E7A0 esp=0022E778 program=c:\cygwin\bin\bash.exe, pid 320, thread 
main
cs=001B ds=0023 es=0023 fs=0038 gs=0000 ss=0023
Stack trace:
Frame     Function  Args
0022E7A0  61098E82  (00000000, 7FFDEBF8, 00341F18, 0022E7A4)
0022E7D0  610708C9  (61730180, 00342174, 77F65357, 00000000)
0022E810  61070B0B  (61730180, 0022ECF8, 00000001, 00000000)
0022E840  61068CC9  (61068C3F, 0022ECF8, 0022E8A4, 00000000)
0022EE20  61069968  (00000000, 61020DBC, 00000103, 0022EE4C)
0022EFC0  61070492  (0A0504ED, 00000001, 0022F000, 6101FCD1)
0022EFD0  610705F9  (0A0504ED, 6101FC71, 0022F000, 6105C50B)
0022F000  6101FCD1  (0A0500E4, 0A0504ED, 77E7AE47, 0022F028)
0022F050  6102123A  (00000001, 00000000, 00000002, 0022F0C8)
0022F070  6107145B  (00000000, 00000000, 0022F090, 0022F0C8)
0022F0B0  61005BD4  (0022F0C8, 00000000, 0000001B, 00240B98)
0022FF90  610061AB  (00000000, 00000000, 00000000, 00000000)
End of stack trace


------=_NextPart_000_3fec_693a_529c--
