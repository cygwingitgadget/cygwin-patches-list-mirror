Return-Path: <cygwin-patches-return-2697-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28161 invoked by alias); 24 Jul 2002 08:08:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28146 invoked from network); 24 Jul 2002 08:08:04 -0000
Date: Wed, 24 Jul 2002 01:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: serial patch - second attempt
Message-ID: <20020724100802.K13588@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3D327F4D.C8E80EB8@certum.pl> <20020723165007.E13588@cygbert.vinschen.de> <3D3E5EE3.874A9705@certum.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3E5EE3.874A9705@certum.pl>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00145.txt.bz2

On Wed, Jul 24, 2002 at 10:01:39AM +0200, Jacek Trzcinski wrote:
> Hi !
> I think that there is a problem with this name. In case of serial
> initialization (in method fhandler_serial::open()) it could be utilized
> because its goal is connected with name - it initializes RTS and DTR
> serial lines. Problem is in method fhandler_serial::ioctl().
> Conditional paths utilized by me are concerned with the fact that under
> NT , native serial device driver supports reading of RTS and DTR lines
> by DeviceIoControl() function. Under 9x native serial driver does not
> support it so utilized variables dsr and rts, setting in different
> places of fhandler_serial.cc. Thus in my opinion, saying
> "must_init_serial_line" in ioctl() method is not accurate because there
> is none initialization there.

> > If you think that the name of the new capability is inappropriate,
> > please suggest another name.

!!!!!

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
