Return-Path: <cygwin-patches-return-3612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22330 invoked by alias); 21 Feb 2003 15:32:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22303 invoked from network); 21 Feb 2003 15:32:21 -0000
Date: Fri, 21 Feb 2003 15:32:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access()
Message-ID: <20030221153236.GD26242@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030220201534.007fb310@mail.attbi.com> <20030221143127.GL1403@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221143127.GL1403@cygbert.vinschen.de>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00261.txt.bz2

On Fri, Feb 21, 2003 at 03:31:27PM +0100, Corinna Vinschen wrote:
>On Thu, Feb 20, 2003 at 08:15:34PM -0500, Pierre A. Humblet wrote:
>> However bash already uses access() when AFS is defined. Thus it
>> would be a 1/2 line patch in bash (test.c and findcmd.c) to also
>> use access() for Cygwin. 
>> - #if defined (AFS)
>> + #if defined (AFS) || defined (__CYGWIN__)
>> That would be a significant improvement, IMO. What do you think?
>
>Yes, I'll change that.  Thanks for the hint.
>
>> 2003-02-21  Pierre Humblet  <pierre.humblet@ieee.org>
>> 
>> 	* autoload.cc (AccessCheck): Add.
>> 	(DuplicateToken): Add.
>> 	* security.h (check_file_access): Declare.
>> 	* syscalls.cc (access): Convert path to Windows, check existence
>> 	and readonly attribute. Call check_file_access instead of acl_access.
>> 	* security.cc (check_file_access): Create.
>> 	* sec_acl (acl_access): Delete.
>
>I'm impressed.  Works nice with no more handcrafted messing around
>with ACLs.

If I read Pierre's previous message correctly, it sounds like /bin/test
is now broken.  Was someone going to fix that?

cgf
