Return-Path: <cygwin-patches-return-5086-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14057 invoked by alias); 27 Oct 2004 05:18:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14047 invoked from network); 27 Oct 2004 05:18:14 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "'cygwin-patches mailing-list'" <cygwin-patches@cygwin.com>
Subject: RE: sync(3)
Date: Wed, 27 Oct 2004 05:18:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <417F09A1.4090003@x-ray.at>
X-SW-Source: 2004-q4/txt/msg00087.txt.bz2
Message-ID: <20041027051800.bfD0LiUnFXgZhmRjidq5Wo6mHPZ9FK1BP9c_mVOpQAw@z>

Well, I don't know if it's a bad idea, but FlushFileBuffers isn't guaranteed
to do anything, and usually doesn't in the very instances that you need it
most.  But since sync(3) isn't guaranteed to do anything anyway, I guess it
cancels out.

I'd be sure to put comments in there saying that it really can't be relied
on to do anything though.  That will avoid people who come along later, see
that sync looks like it should be "working" but isn't, and wonder what's
wrong when there really isn't anything "wrong".

-- 
Gary R. Van Sickle
 

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Reini Urban
> Sent: Tuesday, October 26, 2004 9:36 PM
> To: cygwin-patches mailing-list
> Subject: sync(3)
> 
> Why is this a bad idea?
> --
> Reini Urban
> http://xarch.tu-graz.ac.at/home/rurban/
> 
> 
