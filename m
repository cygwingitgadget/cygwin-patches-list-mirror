Return-Path: <cygwin-patches-return-3883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30181 invoked by alias); 24 May 2003 16:11:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30151 invoked from network); 24 May 2003 16:11:29 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 24 May 2003 16:11:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Micha Nelissen <mdvpost@hotmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: Escape sequence for codepage switch
In-Reply-To: <BAY1-DAV40Yb9vPXtzf0002802a@hotmail.com>
Message-ID: <Pine.GSO.4.44.0305241210130.26092-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0305241210132.26092@slinky.cs.nyu.edu>
X-SW-Source: 2003-q2/txt/msg00110.txt.bz2

On Sat, 24 May 2003, Micha Nelissen wrote:

> Hi,
>
> Added escape sequence to let programs switch the current codepage to enable
> linedrawing characters. These work only if the termcap entry is changed,
> adding 'ae=\E[z' and 'as=\E[y' capabilities. For use of cygwin in Command
> Prompt.
>
> Micha.

Micha,

How does this interact with the 'codepage:' setting in the CYGWIN
environment variable?  Does the above make this setting obsolete?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
