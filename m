Return-Path: <cygwin-patches-return-4054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6294 invoked by alias); 9 Aug 2003 19:20:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6285 invoked from network); 9 Aug 2003 19:20:18 -0000
Message-ID: <3F3548E8.1040605@cwilson.fastmail.fm>
Date: Sat, 09 Aug 2003 19:20:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu> <20030809161211.GB9514@redhat.com> <20030809162939.GA9863@redhat.com>
In-Reply-To: <20030809162939.GA9863@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00070.txt.bz2

Christopher Faylor wrote:


> I'll check this in but it would be nice if (WBNI) this used a mingw gzip
> library rather than calling gzip directly.  That's a fair amount of
> work but I could resurrect the zlib library in winsup if necessary.
> 
> I wonder why setup is using gzip rather than bzip2 for the package files...

the setup tree contains its own copies of the zlib and bzlib trees; 
thue, they are compiled under the same runtime that setup is.  If setup 
is a 'mingw' app, then so are the internal, statically linked libz and 
bz2lib.

I imagine that the reason Igor used popen and zcat is simply that it was 
easier than directly interfacing to the library.  Perhaps that issue 
could be addressed in a later patch (along the lines of the compress_gz 
class, which also provides uncompression capabilities?)

--
Chuck

