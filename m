Return-Path: <cygwin-patches-return-4439-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22675 invoked by alias); 26 Nov 2003 02:13:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22654 invoked from network); 26 Nov 2003 02:13:12 -0000
Date: Wed, 26 Nov 2003 02:13:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031126021312.GD24422@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00158.txt.bz2

On Tue, Nov 25, 2003 at 08:55:33PM -0500, Pierre A. Humblet wrote:
>This patch will stop the "CreateFileMapping, Win32 error 5. Terminating."
>complaints.
>
>It changes shared_name() to avoid setting the Global\ prefix on file mappings
>when the Create Global Object privilege may be required but the user doesn't
>have it. 
>
>Note that when running from the console or as a service, the names are
>looked up
>in the global name space by default (with or without privilege), thus it
>doesn't
>matter if the prefix is Global\ or "". 
>In other words, there is no need to determine if the user is running from 
>Terminal Services.
>
>As a side effect, the cygheap must be initialized earlier in the startup
>sequence because it is needed for CloseHandle when debugging is enabled
>(thus the changes in memory_init and shared_info::initialize).
>
>I don't have access to Terminal Services to test the patch, but Fabrice
>Larribe
>reports that it works fine on a system where he needed, but couldn't get, the
>privilege. 
>
>Pierre
>
>2003-11-25  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* shared.cc (shared_name): Take into account the SE_CREATE_GLOBAL_NAME
>	privilege when building the name string.
>	(open_shared): Remove the call to OpenFileMapping.
>	(shared_info::initialize): Move cygheap initialization to ...	
>	(memory_init): ... here. Suppress now useless shared_h variable.
>	(user_shared_initialize): Make tu a cygpsid.
>	* sec_helper.cc (set_process_privilege): Call LookupPrivilegeValue
>	before opening the token.

>Index: shared.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
>retrieving revision 1.78
>diff -u -p -r1.78 shared.cc
>--- shared.cc	14 Nov 2003 23:40:05 -0000	1.78
>+++ shared.cc	26 Nov 2003 01:37:57 -0000
>@@ -35,9 +35,14 @@ char * __stdcall
> shared_name (char *ret_buf, const char *str, int num)
> {
>   extern bool _cygwin_testing;
>+  static const char * prefix = NULL;
>
>-  __small_sprintf (ret_buf, "%s%s.%s.%d",
>-  		   wincap.has_terminal_services () ?  "Global\\" : "",
>+  if (!prefix)
>+    prefix = wincap.has_terminal_services ()
>+             && ( set_process_privilege (SE_CREATE_GLOBAL_NAME, true) >= 0
>+		  || GetLastError () == ERROR_NO_SUCH_PRIVILEGE) ? "Global\\" : "";
>+

Do you really have to check prefix every time shared_name is called like
this?  Couldn't you just initialize prefix prior to calling shared_name?

Other than that minor point, this looks ok.

cgf
