Return-Path: <cygwin-patches-return-2060-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11998 invoked by alias); 15 Apr 2002 15:09:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11965 invoked from network); 15 Apr 2002 15:09:34 -0000
Message-ID: <3CBAEDF1.647F5DC6@ieee.org>
Date: Mon, 15 Apr 2002 08:09:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de> <3CBADAE5.92A542FE@ieee.org> <20020415162809.P29277@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00044.txt.bz2

Corinna Vinschen wrote:

> Sorry if I'm dense but... shouldn't the new FD_SETCF functionality
> allow to do the "right thing" without adding the oldsocks variable
> at all?!?  You wrote about the disadvantage that the child inherits
> that array...

The oldsocks array is needed in the parent because the MS bug
precisely requires the last close() on a socket to be done by 
the parent, after all other processes referencing the socket 
are gone (*). 

It's true that the oldsocks array is not needed in the child.
Is there a way  to declare a variable "NO_COPY" in an application?
However the oldsocks array is just a an array of integers. The child
can't (and won't try anyway) make use of them because the underlying 
handles have not been duplicated. 

(*) My example code assumes that the child has not created detached 
processes that keep accessing the socket after the child has
exited (but exec() chains are OK). 
Is that the case for applications created by inetd & sshd? 
If this assumption is not true, then shutdown() can't be called 
in the parent and CLOSE_WAIT may still occur, albeit at a reduced 
frequency [probably]. 
 
Pierre
