Return-Path: <cygwin-patches-return-3886-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28448 invoked by alias); 24 May 2003 18:01:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28412 invoked from network); 24 May 2003 18:01:07 -0000
Date: Sat, 24 May 2003 18:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: End of buffer suppress scroll
Message-ID: <20030524180106.GC5604@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY1-DAV408dRYtEcNi00028051@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-DAV408dRYtEcNi00028051@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00113.txt.bz2

On Sat, May 24, 2003 at 03:41:53PM +0200, Micha Nelissen wrote:
>Hi,
>
>This scroll is not with scrollbar, but when adding a line. When a character
>is written in right bottom cell, all of buffer is scrolled. With this patch,
>the cursor can be 'out of range' while waiting for the first character on
>the new line to be written. I have also tried to explain it on my previous
>big patch, but it is hard to explain, however easy to see when you've
>applied the patch.

You explained this but I still think there is an escape sequence which controls
what happens when a character shows up in the lower right corner.  I thought
there was a termcap/terminfo setting for this, too.

cgf
