Return-Path: <cygwin-patches-return-2789-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30379 invoked by alias); 7 Aug 2002 17:38:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30347 invoked from network); 7 Aug 2002 17:38:16 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 07 Aug 2002 10:38:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: regtool support for custom key separators
Message-ID: <Pine.GSO.4.44.0208071300240.9607-100000@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00237.txt.bz2

Hi all,

The attached patch allows the users of regtool to specify a custom separator
between the key and the value for the 'set' and 'unset' actions.
E.g.
	regtool -K@ set "/HKLM/SOFTWARE/Cygnus Solutions/Cygwin/Program Options@c:\\\\cygwin\\\\bin\\\\ssh.exe" "tty export"

This is necessary for creating registry values with names containing a '\\'.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

It took the computational power of three Commodore 64s to fly to the moon.
It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file

