Return-Path: <cygwin-patches-return-4778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15078 invoked by alias); 19 May 2004 17:42:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14813 invoked from network); 19 May 2004 17:42:12 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 19 May 2004 17:42:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin@cygwin.com
To: "Kleinert, Marcel" <marcel.kleinert@hp.com>
cc: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: Question concerning SSHD on CYGWIN
In-Reply-To: <2A9F70D12FA9034E8D9EF31894A0B22F27CEA1@bbnexc03.emea.cpqcorp.net>
Message-ID: <Pine.GSO.4.58.0405191329300.17826@slinky.cs.nyu.edu>
References: <2A9F70D12FA9034E8D9EF31894A0B22F27CEA1@bbnexc03.emea.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q2/txt/msg00130.txt.bz2

Wrong list.  Please see <http://cygwin.com/lists.html#available-lists> for
details.  In the meantime, I've redirected this to the correct one.
Please remove cygwin-patches from further discussion on this topic unless
you actually submit a patch to Cygwin.
	Igor

On Wed, 19 May 2004, Kleinert, Marcel wrote:

> Hello,
>
> For a internal prototype we are using cygwin on a windows 2000 system to
> transfer data via ssh from one windows machine to this windows system
> with   cygwin sshd.
>
> If we have alot of data to transfer (e.g. 800 MB) after approximately 10
> minutes the transfer hangs
> without an exception.
>
> So I opened the log file for sshd on the cygwin folder on the target
> machine. In this log file
> I have the following messages:
>
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  9 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 != 20
>    3583 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 != 20
> 1237139 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 != 20
> 1245150 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 != 20
> 1529145 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 != 20
> 1536801 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 != 20
> 3581925 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 != 20
> 3591269 [sig] sshd 2148 wait_sig: short read from signal pipe: 2 != 20
> 6645385 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 != 20
> 6883663 [sig] sshd 2148 wait_sig: short read from signal pipe: 1 != 20
>       9 [main] sshd 3684 sig_send: error sending signal 28 to pid 3684, pipe handle 0x300, Win32 error 5
>  561758 [proc] sshd 3684 sig_send: error sending signal 20 to pid 3684, pipe handle 0x300, Win32 error 5
>    7482 [main] sshd 1556 sig_send: error sending signal 28 to pid 1556, pipe handle 0x300, Win32 error 5
>  474317 [proc] sshd 1556 sig_send: error sending signal 20 to pid 1556, pipe handle 0x300, Win32 error 5
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> I am not really sure what the problem is. I also tried to transfer the
> data to a unix ssh daemon.
> With this daemon I had no problems. The whole 800 MB was transferred
> successfully.
>
> Do you think thats a bug in the ssh daemon of cygwin? And if it is a bug
> to you know how to fix it ?
>
> Thanks alot for your help in advance.
>  Marcel Kleinert

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
