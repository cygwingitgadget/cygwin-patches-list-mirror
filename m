Return-Path: <cygwin-patches-return-3555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28213 invoked by alias); 13 Feb 2003 20:23:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28118 invoked from network); 13 Feb 2003 20:23:29 -0000
Message-ID: <20030213202327.31827.qmail@web20003.mail.yahoo.com>
Date: Thu, 13 Feb 2003 20:23:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: Produce beeps using soundcard
To: Vaclav Haisman <V.Haisman@sh.cvut.cz>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20030213012822.A20310-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2003-q1/txt/msg00204.txt.bz2

From 'man bash':
       escape sequences, if present, are decoded as follows:
              \a     alert (bell)

Wouldn't this be better called "bell" or "alert"?

--- Vaclav Haisman <V.Haisman@sh.cvut.cz> wrote:
> 
> Hi,
> this small patch adds an ability to produce beeps (\a) using soundcard by
> MessageBeep() call. It can be enabled by new CYGWIN option winbeep.
> 
> Vaclav Haisman
> 
> 2003-02-13  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
> 	* environ.cc (windows_beep): New variable declaration.
> 	(parse_thing): New CYGWIN option.
> 	* fhandler_console.cc (windows_beep): New variable definition.
> 	(fhandler_console::write_normal):  Handle the new option.
> 	* Makefile.in (DLL_IMPORTS): Add libuser32.a for MessageBeep.

__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com
