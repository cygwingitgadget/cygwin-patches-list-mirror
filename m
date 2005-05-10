Return-Path: <cygwin-patches-return-5442-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23710 invoked by alias); 10 May 2005 15:11:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23665 invoked from network); 10 May 2005 15:11:38 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 10 May 2005 15:11:38 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 9316313C9F2; Tue, 10 May 2005 11:11:38 -0400 (EDT)
Date: Tue, 10 May 2005 15:11:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050510151138.GT15665@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050505225708.00b64250@incoming.verizon.net> <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00038.txt.bz2

On Mon, May 09, 2005 at 08:16:36PM -0400, Pierre A. Humblet wrote:
>At 06:19 PM 5/9/2005 +0000, Eric Blake wrote:
>
>>Second, the sequence chdir("//"), mkdir("machine") creates machine in the 
>>current directory.
>
>Old bug. 
>chdir("/proc"), mkdir("machine") produces the same result.
>And mkdir("/proc"), mkdir("/proc/machine") creates c:\proc\machine
>
>The fix sets errno to EROFS, which is what rmdir is already doing.
>Is that OK for coreutils?
>
>Pierre
>   
>2005-05-10  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* dir.cc (isrofs): New function.
>	(mkdir): Use isrofs.
>	(rmdir): Ditto.

Could we see this as a unified-diff please?

cgf
