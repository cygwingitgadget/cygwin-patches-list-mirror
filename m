Return-Path: <cygwin-patches-return-4454-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20645 invoked by alias); 30 Nov 2003 17:15:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20636 invoked from network); 30 Nov 2003 17:15:36 -0000
Message-ID: <3FCA25B1.20507@netscape.net>
Date: Sun, 30 Nov 2003 17:15:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]:  Add flock syscall emulation
References: <Pine.CYG.4.58.0311271409240.1064139@reddragon.clemson.edu> <20031129230104.GA6964@cygbert.vinschen.de> <20031130020821.GA10649@redhat.com>
In-Reply-To: <20031130020821.GA10649@redhat.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00173.txt.bz2

cgf@redhat.com wrote:
> On Sun, Nov 30, 2003 at 12:01:04AM +0100, Corinna Vinschen wrote:
> 
> 
> 
> Is there any reason this can't be a .cc rather than a .c

?

I was just following what was done with other pure C source files, such 
as fnmatch.c.  However, I'll make a note to use .cc in the future.

Cheers,
Nicholas
