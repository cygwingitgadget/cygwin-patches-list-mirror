Return-Path: <cygwin-patches-return-3614-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24830 invoked by alias); 21 Feb 2003 16:31:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24806 invoked from network); 21 Feb 2003 16:30:59 -0000
Message-ID: <3E5654D1.64363760@ieee.org>
Date: Fri, 21 Feb 2003 16:31:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: access()
References: <3.0.5.32.20030220201534.007fb310@mail.attbi.com> <20030221143127.GL1403@cygbert.vinschen.de> <20030221153236.GD26242@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00263.txt.bz2

Christopher Faylor wrote:

> If I read Pierre's previous message correctly, it sounds like /bin/test
> is now broken.  Was someone going to fix that?

It's not any worse than before but not as good as sh, or (soon) bash.
I was going to mention this to the sh-utils maintainer :)

I can send a proper patch (where?), but essentially in test.c

+ #ifdef (__CYGWIN__)
+ #define eaccess(x,y) access(x,y)
+ #else
static int
eaccess (char *path, int mode)
{
  struct stat st;

and a matching #endif

Pierre
