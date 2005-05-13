Return-Path: <cygwin-patches-return-5450-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24650 invoked by alias); 13 May 2005 19:59:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24546 invoked from network); 13 May 2005 19:59:02 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 13 May 2005 19:59:02 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 2996D13CA12; Fri, 13 May 2005 15:59:02 -0400 (EDT)
Date: Fri, 13 May 2005 19:59:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050513195902.GA23129@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050505225708.00b64250@incoming.verizon.net> <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net> <20050511085307.GA2805@calimero.vinschen.de> <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com> <20050512200222.GD5569@trixie.casa.cgf.cx> <20050513135745.GD10577@trixie.casa.cgf.cx> <loom.20050513T164025-465@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050513T164025-465@post.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00046.txt.bz2

On Fri, May 13, 2005 at 02:41:03PM +0000, Eric Blake wrote:
>> I added read-only filesystem checking to path_conv::check so the latest
>> snapshot seems to work fine with the latest coreutils (trixie is a
>> system in my home network which exports shares):
>
>Almost.  With the 20050513 snapshot and coreutils-5.3.0-6, I am still getting:
>
>$ cd //eblake/share
>$ ls
>$ mkdir //eblake/share/dir
>$ ls
>dir  share
>
>So you solved the mkdir("//server"), but not the mkdir("//server/share"), from 
>creating a subdirectory in the most recent non-virtual current directory.

This is fixed in the latest snapshot.  This turned out to be a really
simple fix which probably did not necessitate any of the EROFS stuff.
Oh well.

cgf
