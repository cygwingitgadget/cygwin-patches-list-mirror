Return-Path: <cygwin-patches-return-3168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16203 invoked by alias); 14 Nov 2002 03:40:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16194 invoked from network); 14 Nov 2002 03:40:57 -0000
Message-Id: <3.0.5.32.20021113223509.0082c960@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 13 Nov 2002 19:40:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
In-Reply-To: <20021113175002.Y10395@cygbert.vinschen.de>
References: <3DD27B59.3FA8990@ieee.org>
 <3DD159F7.45001468@ieee.org>
 <20021113135916.Q10395@cygbert.vinschen.de>
 <3DD27B59.3FA8990@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00119.txt.bz2

At 05:50 PM 11/13/2002 +0100, Corinna Vinschen wrote:
>
>The above ls -l example shows the result if we don't use is_grp_member().
>We already had a lot of problems due to this some time ago.  I won't return
>to the old state.  I, for one, would better like to improve is_grp_member().

Hello Corinna,

Sorry, didn't respond to that paragraph in my previous e-mail.
I agree that is_grp_member () is useful and withdraw my suggestion to 
eliminate it.
It's also clear that the Windows and Posix security models do not
match perfectly, and it's impossible to deduce the "owner mode"
from a Windows ACL (except if built by Cygwin, or with hierarchical
permissions). There is no way to make is_grp_member work perfectly, 
as one cannot predict the groups that a user will be in when she 
accesses a file. 
I would say that the comparison (on your example) of the existing method 
and the current patch show that the current patch better reflects the 
"reality", because it only tries to do so when the actual current token 
groups are known and the "reality" is well defined (*). 
Thus I suggest that we use the method of the patch for now, and think
of improving is_grp_member if/as we get specific reports of problems. 
What do you think?

Pierre

(*) I just noticed that getgroups32 should read the impersonation token
if it exists.
