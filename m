Return-Path: <cygwin-patches-return-3597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15196 invoked by alias); 19 Feb 2003 17:57:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15173 invoked from network); 19 Feb 2003 17:57:29 -0000
Date: Wed, 19 Feb 2003 17:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030219175738.GA3544@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000701c2d7b3$fbed0e90$78d96f83@pomello> <20030219021346.P54058-100000@logout.sh.cvut.cz> <20030219012118.GC5253@redhat.com> <3E53A525.9080405@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E53A525.9080405@hekimian.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00246.txt.bz2

On Wed, Feb 19, 2003 at 10:39:17AM -0500, Joe Buehler wrote:
>Christopher Faylor wrote:
>
>>>Because it runs as Cygwin app which is Unix-like environment.  There is
>>>no way to set files sparse in Unix because all files are sparse if the
>>>file systems supports it.
>>
>>...which is, coincidentally enough, why I was interested in the patch.
>
>It seems like a win to me -- UNIX files are always sparse by default: if you
>seek to a location and write, blocks are filled in only at the location of
>the write.
>
>One thing to investigate would be what happens when Windows trys to mmap()
>a sparse file.  It doesn't bother a UNIX box, but Windows?  Perhaps that
>is what BitTorrent is presently doing?

Hmm.  Good point.  Does some brave soul want to apply the patch and do some
experimenting?

cgf
