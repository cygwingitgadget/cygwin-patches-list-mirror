Return-Path: <cygwin-patches-return-3192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23349 invoked by alias); 15 Nov 2002 18:54:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23274 invoked from network); 15 Nov 2002 18:54:11 -0000
Date: Fri, 15 Nov 2002 10:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: select on serial fix
Message-ID: <20021115185437.GB3190@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <041a01c28cd7$7ffbf070$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041a01c28cd7$7ffbf070$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00143.txt.bz2

On Fri, Nov 15, 2002 at 01:47:48PM -0500, Sergey Okhapkin wrote:
>The patch fixes a problem with a characters loss on select on a serial port.
>I wonder what PurgeComm() calls in the original code supposed to do...

Dunno.  I probably wrote the code, too.

>2002-11-15  Sergey Okhapkin  <sos@prospect.com.ru>
>
>	* select.cc (peek_serial): Don't call PurgeComm() to avoid
>	characters loss.

Applied.  Thanks.

cgf
