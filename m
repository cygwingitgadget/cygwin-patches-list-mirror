Return-Path: <cygwin-patches-return-5396-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19772 invoked by alias); 30 Mar 2005 00:14:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19754 invoked from network); 30 Mar 2005 00:14:08 -0000
Received: from unknown (HELO mtiwmhc12.worldnet.att.net) (204.127.131.116)
  by sourceware.org with SMTP; 30 Mar 2005 00:14:08 -0000
Received: from dfw5rb41 (h-68-165-190-56.chcgilgm.dynamic.covad.net[68.165.190.56])
          by worldnet.att.net (mtiwmhc12) with SMTP
          id <2005033000140811200m9gnje>; Wed, 30 Mar 2005 00:14:08 +0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH]: "decorate" gcc extensions with __extension__
Date: Wed, 30 Mar 2005 00:14:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <4249E5D0.1000201@gawab.com>
X-SW-Source: 2005-q1/txt/msg00099.txt.bz2
Message-ID: <20050330001400.MPHCi-yHWE9H1aQeB69KiuwEs9tJujVeqVmohf_ZkyQ@z>

> > Btw, the use of a ?: c is a conscious decision.
> 
> Maybe I'm just old fashion and do not like "a ? : c", but I 
> don't understand why you use it, other than saving a few 
> keystrokes.  Look, aside from the fact it keeps -pedantic 
> from producing an error, explicitly expanding to "a ? a : c"
> makes the code easier to read and the intent more clear.  

Yikes.  I didn't even know you could do "a ? : c".  When did C++ become
Perl?

-- 
Gary R. Van Sickle
