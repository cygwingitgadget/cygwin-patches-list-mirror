Return-Path: <cygwin-patches-return-3596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14342 invoked by alias); 19 Feb 2003 15:39:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14333 invoked from network); 19 Feb 2003 15:39:17 -0000
Message-ID: <3E53A525.9080405@hekimian.com>
Date: Wed, 19 Feb 2003 15:39:00 -0000
X-Sybari-Trust: 9d5ce590 f29b823d 8896dc64 00000139
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
References: <000701c2d7b3$fbed0e90$78d96f83@pomello> <20030219021346.P54058-100000@logout.sh.cvut.cz> <20030219012118.GC5253@redhat.com>
In-Reply-To: <20030219012118.GC5253@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00245.txt.bz2

Christopher Faylor wrote:

>>Because it runs as Cygwin app which is Unix-like environment.  There is
>>no way to set files sparse in Unix because all files are sparse if the
>>file systems supports it.
> 
> ...which is, coincidentally enough, why I was interested in the patch.

It seems like a win to me -- UNIX files are always sparse by default: if you
seek to a location and write, blocks are filled in only at the location of
the write.

One thing to investigate would be what happens when Windows trys to mmap()
a sparse file.  It doesn't bother a UNIX box, but Windows?  Perhaps that
is what BitTorrent is presently doing?
-- 
Joe Buehler
