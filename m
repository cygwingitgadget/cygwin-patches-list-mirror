Return-Path: <cygwin-patches-return-1541-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 17156 invoked by alias); 28 Nov 2001 00:32:21 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 17133 invoked from network); 28 Nov 2001 00:32:19 -0000
Message-ID: <3C043080.D0E3AD8C@yahoo.com>
Date: Wed, 24 Oct 2001 16:04:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: CP List <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  
 header
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com> <1006906033.2048.23.camel@lifelesswks> <20011128002122.GA6919@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00073.txt.bz2

Christopher Faylor wrote:
> 
> 
> Why?  For the reasons that both Gary and I mentioned.  It's self
> documenting?
> 
> Did you miss the point that I decided on the !foo because I had no
> choice?
> 

Once upon a time, not so very long ago, your self documentation added
precious cycles to the processing.  GCC fortunately is smart enough to
know how to get this right regardless.  I.E.: It makes no freaking
difference because the assembler is the same. ;)

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

