Return-Path: <cygwin-patches-return-4154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28739 invoked by alias); 31 Aug 2003 21:06:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28730 invoked from network); 31 Aug 2003 21:06:28 -0000
Date: Sun, 31 Aug 2003 21:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030831210627.GA10412@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <20030829031256.GA18890@redhat.com> <3F4F60EA.4DBB8A51@phumblet.no-ip.org> <3.0.5.32.20030830152207.007bde60@incoming.verizon.net> <3.0.5.32.20030831112352.008161c0@incoming.verizon.net> <3.0.5.32.20030831161147.008294d0@incoming.verizon.net> <3.0.5.32.20030831164810.008161c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030831164810.008161c0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00170.txt.bz2

On Sun, Aug 31, 2003 at 04:48:10PM -0400, Pierre A. Humblet wrote:
>Sorry I misunderstood. Exactly where did you add a Sleep?

In sig_dispatch_pending after the sigframe.

cgf
