Return-Path: <cygwin-patches-return-4443-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8696 invoked by alias); 26 Nov 2003 14:32:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8685 invoked from network); 26 Nov 2003 14:32:05 -0000
Date: Wed, 26 Nov 2003 14:32:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031126143204.GN21540@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00162.txt.bz2

On Tue, Nov 25, 2003 at 08:55:33PM -0500, Pierre A. Humblet wrote:
> This patch will stop the "CreateFileMapping, Win32 error 5. Terminating."
> complaints.
> 
> It changes shared_name() to avoid setting the Global\ prefix on file mappings
> when the Create Global Object privilege may be required but the user doesn't
> have it. 
> 
> Note that when running from the console or as a service, the names are
> looked up
> in the global name space by default (with or without privilege), thus it
> doesn't
> matter if the prefix is Global\ or "". 
> In other words, there is no need to determine if the user is running from 
> Terminal Services.
> 
> As a side effect, the cygheap must be initialized earlier in the startup
> sequence because it is needed for CloseHandle when debugging is enabled
> (thus the changes in memory_init and shared_info::initialize).
> 
> I don't have access to Terminal Services to test the patch, but Fabrice
> Larribe
> reports that it works fine on a system where he needed, but couldn't get, the
> privilege. 

I have a problem with this patch.

While the SE_CREATE_GLOBAL_NAME privilege is needed in a terminal session
to create a global object, it's not needed to *access* a global object,
right?  Wouldn't it be better, if the functions would try to access the
global object first, and only if that fails, try to create the object
according to its privilege?

Imagine a sshd service is running on the system.  This service has the
SE_CREATE_GLOBAL_NAME privilege and would create the global object on
system startup (given the service is in automatic mode).  Other processes
would then be able to access the global object, regardless if running in
a terminal session or not.  This would keep the process list together,
for instance.

Also, shouldn't the prefix variable have a NO_COPY attribute?  If the
process setuids and forks, the new process might have different privileges
which might or might not result in the need to use a different object
name space.

The sec_helper.cc patch is fine.  I've applied it together with a patch
I should have made already long ago.  I renamed the restore_priv variable
which name stems from the fact, that the function only had set the
SE_RESTORE_NAME privilege originally.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
