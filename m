Return-Path: <cygwin-patches-return-3125-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30393 invoked by alias); 5 Nov 2002 23:15:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30299 invoked from network); 5 Nov 2002 23:15:08 -0000
Date: Tue, 05 Nov 2002 15:15:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More fhandler_serial fixes.
Message-ID: <20021105231705.GA12749@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <007901c28515$e66596a0$0201a8c0@sos> <20021105222840.GB11142@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105222840.GB11142@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00076.txt.bz2

On Tue, Nov 05, 2002 at 05:28:40PM -0500, Christopher Faylor wrote:
>On Tue, Nov 05, 2002 at 04:54:19PM -0500, Sergey Okhapkin wrote:
>>The patch fixes sume bugs/typos in fhandler_serial
>>
>>2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>
>>
>>        * fhandler_serial.cc (fhandler_serial::raw_read): Use correct type,
>>fix typo.
>>        (fhandler_serial::ioctl): Fix ClearCommError() return value check,
>>         set errno if the call failed.
>>         Don't give up if DeviceIoCtl() failed, but fall back to Win95
>>method.
>>        (fhandler_serial::tcsetattr): Use correct value for vmin_.
>>        (fhandler_serial::tcgetattr): Ditto.
>
>Is there any way that you could send this as regular text or even as an
>attachment.  It's hard to respond to patches when they're uunencoded.

Responding to decoded patch:

>-  DWORD minchars = vmin_ ?: ulen;
>+  size_t minchars = vmin_ ?vmin_: ulen;

I could see changing this to size_t but not adding the extra vmin_.

>@@ -423,20 +426,21 @@ fhandler_serial::ioctl (unsigned int cmd
>                                               0, &mcr, 4, &cb, 0);
>                if (!result)
>                  {
>-                   __seterrno ();
>-                   res = -1;
>-                   goto out;
>+                   modem_status |= rts | dtr;

This is saying that if a function (DeviceIoControl) fails we fallback to
Win95 behavior.  Why wouldn't we want to reflect the failure of the
function?  Otherwise we could be masking an actual failure.

Anyway, I've checked in a variation of this change minus the
DeviceIoControl part.

cgf
