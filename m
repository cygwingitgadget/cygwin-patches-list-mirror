Return-Path: <cygwin-patches-return-3172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23046 invoked by alias); 14 Nov 2002 14:29:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23019 invoked from network); 14 Nov 2002 14:29:51 -0000
Message-ID: <3DD3B369.A530D7EE@ieee.org>
Date: Thu, 14 Nov 2002 06:29:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <3DD27B59.3FA8990@ieee.org> <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00123.txt.bz2

Corinna Vinschen wrote:
> 
Hello, Corinna
> 
> Isn't the impersonation token automatically read by OpenProcessToken()
> when an impersonation took place?

I don't think so.

> > Thus I suggest that we use the method of the patch for now, and think
> > of improving is_grp_member if/as we get specific reports of problems.
> > What do you think?
> 
> Do you mean my one liner?  If so, I agree.  My patch is just a starting
> point.

- Has anybody reported problems with incorrect owner modes for a file owner
  different from the current process user? If not, I wouldn't even start
  writing code for it. 
  We know it can't work all the time, and that to work assuming the default
  group membership, it needs mkgroup -u (or PDC lookup). Yesterday I checked 
  that at a medium size company (~ 150 persons). There where a total of
  1047 names in the gr_mem fields. getgroups32 scans them all, every time. 
  That would be for every file stat.
  
- I am a little bit confused by your patch. Your intention is to skip the token
  lookup if the file uid isn't that of the current user. You then fall to the
  bottom of getgroups32. But there the gid is ALWAYS included in the group
  list (because in the context of getgroups the gid is that of the user, not
  that of a file). Thus your small patch will always report that the uid is
  a member of the gid.

> Could you then please resend the parts of your #1 patch we agreed upon?

OK. Do you want to call is_grp_member all the time or only if the current user
is the file owner?

Pierre
