Return-Path: <cygwin-patches-return-3282-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22204 invoked by alias); 5 Dec 2002 16:26:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22194 invoked from network); 5 Dec 2002 16:26:22 -0000
Date: Thu, 05 Dec 2002 08:26:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] line_edit return value
Message-ID: <20021205162715.GA9519@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021129200410.A20532@eris.io.com> <20021130222603.GB29907@redhat.com> <20021130170221.A6355@fnord.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021130170221.A6355@fnord.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00233.txt.bz2

On Sat, Nov 30, 2002 at 05:02:21PM -0600, Steve O wrote:
>ChangeLog entry
>2002-11-30 Steve Osborn <bub@io.com>
>	* fhandler.h (fhandler_termios::line_edit): Changed return
>	  from an int to an enum to allow the function to return an
>	  error.
>	* fhandler_console.cc (fhandler_console::read): Updated the
>	  line_edit call to use the new enum.
>	* fhandler_termios.cc (fhandler_termios::line_edit): Changed 
>	  return from an int to an enum to allow the function to return an
>          error.  Put put_readahead call before doecho for future patch. 
>	* fhandler_tty.cc (fhandler_pty_master::write): Changed to 
>	  call line_edit one character at a time, and stop if an error
>	  occurs.

Something was bugging me about this patch Basically it seems like maybe
we ought to be storing the line_edit state in the fhandler_tty structure
or something but maybe that's too big a change.  I couldn't convince
myself that the code would be any clearer as a result of such a change
either.  I could convince myself that the tty stuff needs to be rewritten
from scratch, though.  :-)

Anyway, I've checked this in after reformatting the ChangeLog.

Thanks,
cgf
