Return-Path: <cygwin-patches-return-3127-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17993 invoked by alias); 6 Nov 2002 00:39:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17984 invoked from network); 6 Nov 2002 00:38:59 -0000
Message-ID: <008901c2852c$95703810$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <007901c28515$e66596a0$0201a8c0@sos> <20021105222840.GB11142@redhat.com> <20021105231705.GA12749@redhat.com>
Subject: Re: More fhandler_serial fixes.
Date: Tue, 05 Nov 2002 16:39:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00078.txt.bz2

>
> I could see changing this to size_t but not adding the extra vmin_.
>
> >@@ -423,20 +426,21 @@ fhandler_serial::ioctl (unsigned int cmd
> >                                               0, &mcr, 4, &cb, 0);
> >                if (!result)
> >                  {
> >-                   __seterrno ();
> >-                   res = -1;
> >-                   goto out;
> >+                   modem_status |= rts | dtr;
>
> This is saying that if a function (DeviceIoControl) fails we fallback to
> Win95 behavior.  Why wouldn't we want to reflect the failure of the
> function?  Otherwise we could be masking an actual failure.
>
> Anyway, I've checked in a variation of this change minus the
> DeviceIoControl part.

The call to DeviceIoCtl is
     BOOL result = DeviceIoControl (get_handle (), 0x001B0078, NULL,
                           0, &mcr, 4, &cb, 0);

I heve no ideas what does this call means, it's undocumented. The call
always fails on my W2k when
attempting to get the status of laptop's built-in modem. It seems to me it's
better to ignore the error and to fall back to Win95 behavior rather than
return the error.

Sergey Okhapkin
Somerset, NJ

