Return-Path: <cygwin-patches-return-1876-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15045 invoked by alias); 20 Feb 2002 22:13:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14984 invoked from network); 20 Feb 2002 22:13:19 -0000
Date: Sat, 23 Feb 2002 19:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New file for winsup/utils
Message-ID: <20020220221322.GA3196@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <005501c1b9f7$0928e420$0200a8c0@lifelesswks> <20020220220324.95101.qmail@web20008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020220220324.95101.qmail@web20008.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00233.txt.bz2

On Wed, Feb 20, 2002 at 02:03:24PM -0800, Joshua Daniel Franklin wrote:
>OK, here is a new util:
>
>Usage mkshortcut.exe [OPTION]... TARGET 
>NOTE: All filename arguments must be in unix (POSIX) format
>  -a|--arguments=ARGS   use arguments ARGS 
>  -h|--help             output usage information and exit
>  -i|--icon             icon file for link to use
>  -j|--iconoffset       offset of icon in icon file (default is 0)
>  -n|--name             name for link (defaults to TARGET)
>  -v|--version          output version information and exit
>  -A|--allusers         use 'All Users' instead of current user for -D,-P
>  -D|--desktop          create link relative to 'Desktop' directory
>  -P|--smprograms       create link relative to Start Menu 'Programs' directory

Now that cygutils is part of the distribution, I think this belongs there, if
Chuck is amenable.

With the exception of regtool, all of the programs in winsup/utils are pretty
cygwin-specific.  While this looks like a very nice tool, I think it belongs
elsewhere.

cgf
