Return-Path: <cygwin-patches-return-3126-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13706 invoked by alias); 6 Nov 2002 00:29:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13690 invoked from network); 6 Nov 2002 00:29:57 -0000
Message-ID: <008201c2852b$524de600$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <007901c28515$e66596a0$0201a8c0@sos> <20021105222840.GB11142@redhat.com>
Subject: Re: More fhandler_serial fixes.
Date: Tue, 05 Nov 2002 16:29:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00077.txt.bz2

Sure!

Index: fhandler_serial.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_serial.cc,v
retrieving revision 1.32
diff -u -p -r1.32 fhandler_serial.cc
--- fhandler_serial.cc 4 Nov 2002 04:09:14 -0000 1.32
+++ fhandler_serial.cc 5 Nov 2002 21:45:52 -0000
@@ -43,7 +43,7 @@ fhandler_serial::raw_read (void *ptr, si
   int tot;
   DWORD n;
   HANDLE w4[2];
-  DWORD minchars = vmin_ ?: ulen;
+  size_t minchars = vmin_ ?vmin_: ulen;

   w4[0] = io_status.hEvent;
   w4[1] = signal_arrived;
@@ -387,8 +387,11 @@ fhandler_serial::ioctl (unsigned int cmd

   DWORD ev;
   COMSTAT st;
-  if (ClearCommError (get_handle (), &ev, &st))
-    res = -1;
+  if (ClearCommError (get_handle (), &ev, &st) == 0)
+    {
+      __seterrno ();
+      res = -1;
+    }
   else
     switch (cmd)
       {
@@ -423,20 +426,21 @@ fhandler_serial::ioctl (unsigned int cmd
             0, &mcr, 4, &cb, 0);
   if (!result)
     {
-      __seterrno ();
-      res = -1;
-      goto out;
+      modem_status |= rts | dtr;
     }
-  if (cb != 4)
+  else
     {
-      set_errno (EINVAL); /* FIXME: right errno? */
-      res = -1;
-      goto out;
+      if (cb != 4)
+        {
+          set_errno (EINVAL); /* FIXME: right errno? */
+          res = -1;
+          goto out;
+        }
+      if (mcr & 2)
+        modem_status |= TIOCM_RTS;
+      if (mcr & 1)
+        modem_status |= TIOCM_DTR;
     }
-  if (mcr & 2)
-    modem_status |= TIOCM_RTS;
-  if (mcr & 1)
-    modem_status |= TIOCM_DTR;
        }
      ipbuffer = modem_status;
    }
@@ -794,7 +798,7 @@ fhandler_serial::tcsetattr (int action,

   if (t->c_lflag & ICANON)
     {
-      vmin_ = MAXDWORD;
+      vmin_ = 0;
       vtime_ = 0;
     }
   else
@@ -999,7 +1003,7 @@ fhandler_serial::tcgetattr (struct termi
     t->c_oflag |= ONLCR;

   debug_printf ("vmin_ %d, vtime_ %d", vmin_, vtime_);
-  if (vmin_ == MAXDWORD)
+  if (vmin_ == 0)
     {
       t->c_lflag |= ICANON;
       t->c_cc[VTIME] = t->c_cc[VMIN] = 0;



Sergey Okhapkin
Somerset, NJ
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, November 05, 2002 5:28 PM
Subject: Re: More fhandler_serial fixes.


> On Tue, Nov 05, 2002 at 04:54:19PM -0500, Sergey Okhapkin wrote:
> >The patch fixes sume bugs/typos in fhandler_serial
> >
> >2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>
> >
> >        * fhandler_serial.cc (fhandler_serial::raw_read): Use correct
type,
> >fix typo.
> >        (fhandler_serial::ioctl): Fix ClearCommError() return value
check,
> >         set errno if the call failed.
> >         Don't give up if DeviceIoCtl() failed, but fall back to Win95
> >method.
> >        (fhandler_serial::tcsetattr): Use correct value for vmin_.
> >        (fhandler_serial::tcgetattr): Ditto.
>
> Is there any way that you could send this as regular text or even as an
> attachment.  It's hard to respond to patches when they're uunencoded.
>
> cgf
>
> >begin 666 fhandler_serial.cc.diff

