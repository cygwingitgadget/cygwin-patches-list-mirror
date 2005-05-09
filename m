Return-Path: <cygwin-patches-return-5439-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7438 invoked by alias); 9 May 2005 19:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7308 invoked from network); 9 May 2005 19:39:54 -0000
Received: from unknown (HELO vms040pub.verizon.net) (206.46.252.40)
  by sourceware.org with SMTP; 9 May 2005 19:39:54 -0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IG800I54MM87MA4@vms040.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Mon, 09 May 2005 14:39:46 -0500 (CDT)
Date: Mon, 09 May 2005 19:40:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
To: "Eric Blake" <ebb9@byu.net>,	<cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <007701c554ce$da6167e0$3e0010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
References: <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
 <loom.20050509T200029-6@post.gmane.org>
X-SW-Source: 2005-q2/txt/msg00035.txt.bz2


----- Original Message ----- 
From: "Eric Blake"
To: <cygwin-patches@cygwin.com>
Sent: Monday, May 09, 2005 2:19 PM
Subject: Re: [Patch]: mkdir -p and network drives


> Pierre A. Humblet <pierre <at> phumblet.no-ip.org> writes:
> >
> > Here is a patch to allow mkdir -p to easily work with network
> > drives and to allow future enumeration of computers and of
> > network drives by ls -l.
> >
> > It works by defining a new FH_NETDRIVE virtual handler for
> > names such as // and //machine.
> > This also makes chdir work without additional change.
>
> I've just downloaded the 20050508 snapshot to play with this, and it still
> needs some work before coreutils-5.3.0-6 can be released.  But it is an
> improvement!
>
> First, `ls -ld // //machine' show that these directories are mode 111
> (searchable, but not readable).  Yet opendir("//") and
opendir("//machine")
> succeed, although POSIX requires that opendir(2) fail with EACCESS if the
> directory to be opened is not readable.

That's currently a feature. Being compliant means writing extra code
that will be junked when we make the directories readable.
In what way does non-compliance affect coreutils or the user?
A similar case is that getfacl reports the directories as r-x.

> Second, the sequence chdir("//"), mkdir("machine") creates machine in the
> current directory.

That's a bug. I will look into it. Thanks.

Pierre

