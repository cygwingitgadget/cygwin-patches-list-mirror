Return-Path: <cygwin-patches-return-3904-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3259 invoked by alias); 26 May 2003 15:55:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3228 invoked from network); 26 May 2003 15:55:17 -0000
Date: Mon, 26 May 2003 15:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: End of buffer suppress scroll
Message-ID: <20030526155509.GB12907@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY1-DAV408dRYtEcNi00028051@hotmail.com> <20030524180106.GC5604@redhat.com> <BAY1-DAV71ljENsnqIF0001a86e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-DAV71ljENsnqIF0001a86e@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00131.txt.bz2

On Mon, May 26, 2003 at 01:08:03PM +0200, Micha Nelissen wrote:
>Christopher Faylor wrote:
>> On Sat, May 24, 2003 at 03:41:53PM +0200, Micha Nelissen wrote:
>> You explained this but I still think there is an escape sequence
>> which controls what happens when a character shows up in the lower
>> right corner.  I thought there was a termcap/terminfo setting for
>> this, too.
>
>There is not. Windows always wraps after the last character to the next
>line, except if you turn this off with a call to SetConsoleMode and disable
>the WRAP_AT_EOL flag. Nowhere in the code is such a call. The only possible
>conclusion is that it will always wrap.

I am talking about a *standard* vtxx escape sequence.

cgf
