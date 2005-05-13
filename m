Return-Path: <cygwin-patches-return-5449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31844 invoked by alias); 13 May 2005 14:51:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31792 invoked from network); 13 May 2005 14:51:12 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 13 May 2005 14:51:12 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DWbMW-0002EU-G5
	for cygwin-patches@cygwin.com; Fri, 13 May 2005 16:42:01 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Fri, 13 May 2005 16:42:00 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Fri, 13 May 2005 16:42:00 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Re: [Patch]: mkdir -p and network drives
Date: Fri, 13 May 2005 14:51:00 -0000
Message-ID:  <loom.20050513T164025-465@post.gmane.org>
References:  <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050505225708.00b64250@incoming.verizon.net> <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net> <20050511085307.GA2805@calimero.vinschen.de> <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com> <20050512200222.GD5569@trixie.casa.cgf.cx> <20050513135745.GD10577@trixie.casa.cgf.cx>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q2/txt/msg00045.txt.bz2

> I added read-only filesystem checking to path_conv::check so the latest
> snapshot seems to work fine with the latest coreutils (trixie is a
> system in my home network which exports shares):

Almost.  With the 20050513 snapshot and coreutils-5.3.0-6, I am still getting:

$ cd //eblake/share
$ ls
$ mkdir //eblake/share/dir
$ ls
dir  share

So you solved the mkdir("//server"), but not the mkdir("//server/share"), from 
creating a subdirectory in the most recent non-virtual current directory.

> The "rmdir //" should really say "directory not empty" but that's a fix
> for another day.

Why change it? POSIX specifies EROFS if the directory to be removed is on a 
read-only filesystem, which sounds like the right error for rmdir("//") to me.

--
Eric Blake


