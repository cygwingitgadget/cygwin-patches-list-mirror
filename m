Return-Path: <cygwin-patches-return-3556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4875 invoked by alias); 13 Feb 2003 20:31:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4825 invoked from network); 13 Feb 2003 20:31:14 -0000
Date: Thu, 13 Feb 2003 20:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Produce beeps using soundcard
Message-ID: <20030213203228.GF32279@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030213012822.A20310-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213012822.A20310-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00205.txt.bz2

On Thu, Feb 13, 2003 at 01:34:28AM +0100, Vaclav Haisman wrote:
>
>Hi,
>this small patch adds an ability to produce beeps (\a) using soundcard by
>MessageBeep() call. It can be enabled by new CYGWIN option winbeep.
>
>Vaclav Haisman
>
>2003-02-13  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>	* environ.cc (windows_beep): New variable declaration.
>	(parse_thing): New CYGWIN option.
>	* fhandler_console.cc (windows_beep): New variable definition.
>	(fhandler_console::write_normal):  Handle the new option.
>	* Makefile.in (DLL_IMPORTS): Add libuser32.a for MessageBeep.

I'm sorry but I really don't want to add too many options to the CYGWIN
environment variable.  I don't think this really justifies an option.

cgf
