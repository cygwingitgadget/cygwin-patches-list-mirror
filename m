Return-Path: <cygwin-patches-return-3690-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9040 invoked by alias); 11 Mar 2003 16:41:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9031 invoked from network); 11 Mar 2003 16:41:10 -0000
Message-ID: <3E6E124B.15EAE6A8@ieee.org>
Date: Tue, 11 Mar 2003 16:41:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: fhandler_socket::dup
References: <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2003-q1/txt/msg00339.txt.bz2

Corinna Vinschen wrote:

> Thanks.  We still don't know *why* that happens, though.  That bugs me.

For future reference here is what happens in Jason's experiments.
All of them start in the system service environment and do as follows

A) [optional] call gethostname to initialize wsock
B) setgid/setgroups/setuid to remove 544 from the token
   problem does not occur if 544 stays. Problem occurs even with
   545 (Users), so it's unlikely to a be a file/registry access issue.
C) create socket and call dup (using WSADuplicateSocket method).

There are 4 cases. 
Note that in case 2) the problem occurs before the dup.

1) A absent. Call directly from Windows 
   WSADuplicateSocket fails 10022 WSAEINVAL Invalid argument. 
   "Some invalid argument was supplied. In some instances, it 
   also refers to the current state of the socketfor instance,
   calling accept on a socket that is not listening."

2) A absent. Call through sh -c (doesn't matter if sh initializes wsock)
   socket fails 10106 

   net helpmsg 10106
   "The requested service provider could not be loaded or initialized."

   fgrep 10106 /usr/include/w32api/winerror.h 
    #define WSAEPROVIDERFAILEDINIT 10106L
   WSAPROVIDERFAILEDINIT
   OS dependent 
   Unable to initialize a service provider. 
   "Either a service provider's DLL could not be loaded (LoadLibrary failed)
   or the provider's WSPStartup/NSPStartup function failed."

3) A present. Call directly from Windows
   Everything OK

4) A present. Call through sh -c (doesn't matter if sh initializes wsock)
   WSADuplicateSocket fails 10022
   
> > Just out of curiosity, why hasn't this always been done? I blindly thought
> > it couldn't but I have just looked up MSDN and there is no mention of any
> > restriction of DuplicateHandle with sockets, on any platform.
> 
> Using WinSock2 should workaround the problem with the order in which sockets
> are closed on 9x.

Uh.. Do you have a pointer to that? I am only aware of such problems when
sockets are duplicated across processes (by fork). 

Pierre
