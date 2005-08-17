Return-Path: <cygwin-patches-return-5626-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3950 invoked by alias); 17 Aug 2005 15:29:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3924 invoked by uid 22791); 17 Aug 2005 15:29:31 -0000
Received: from pop.gmx.net (HELO mail.gmx.net) (213.165.64.20)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Wed, 17 Aug 2005 15:29:31 +0000
Received: (qmail invoked by alias); 17 Aug 2005 15:29:28 -0000
Received: from unknown (EHLO mordor) [213.91.247.38]
  by mail.gmx.net (mp004) with SMTP; 17 Aug 2005 17:29:28 +0200
X-Authenticated: #14308112
Date: Wed, 17 Aug 2005 15:29:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
X-X-Sender: ptsekov@mordor
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix for sending SIGHUP when the pty master side is close()-ed
Message-ID: <Pine.CYG.4.58.0508171731330.1696@mordor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-378740911-1124290315=:1696"
Content-ID: <Pine.CYG.4.58.0508171752240.240@mordor>
X-Y-GMX-Trusted: 0
X-SW-Source: 2005-q3/txt/msg00081.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-378740911-1124290315=:1696
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.CYG.4.58.0508171752241.240@mordor>
Content-length: 3524

Hello,

Today, I've finally tracked down the cause of the problem with the stale
subshells on MC exit. In the past I've tried to attack the problem in a
different manner and wasn't looking at the right place - I suspected some
kind of problem / race in the signal handling / delivery, but I was wrong.

Here is a short description of the problem for those who forgot the
details or never knew of its existance.

MC has the ability to spawn a shell and to allow the user to switch
between the MC's ui and this subshell using a keystroke (Ctrl + O).
When in the subshell the user can do anything he/she can do whith a normal
shell. Now, MC doesn't do any special cleanup related to the subshell -
it relies on the fact that when close() is called on a pty master end a
SIGHUP will be send to the app on the other end. Unfortunately sending the
SIGHUP signal doesn't work very well on Cygwin and the subshell started by
MC is rarely killed.

The following code from fhandler_tty_common::close() is responsible for
initiating the sending of a SIGHUP signal in the situation described
above:

[...]
  /* Send EOF to slaves if master side is closed */
  if (!get_ttyp ()->master_alive ())
    {
      termios_printf ("no more masters left. sending EOF");
      SetEvent (input_available_event);
    }
[...]
  termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
  if (!ForceCloseHandle1 (get_handle (), from_pty))
    termios_printf ("CloseHandle (get_handle ()<%p>), %E", get_handle ());
  if (!ForceCloseHandle1 (get_output_handle (), to_pty))
    termios_printf ("CloseHandle (get_output_handle ()<%p>), %E", get_output_handle ());
[...]

The first part of the code will notify the slave that there is pending
input actively forcing it to read data from the master. The
second part of the code will close the the pipes used to talk to the pty
end. Both parts work together to make the slave pty think that there is
EOF condition. The following lines from fhandler_pty_master::close() are
also of interest:

[...]
  if (!get_ttyp ()->master_alive ())
    {
      termios_printf ("freeing tty%d (%d)", get_unit (), get_ttyp
()->ntty);
#if 0
      if (get_ttyp ()->to_slave)
        ForceCloseHandle1 (get_ttyp ()->to_slave, to_slave);
      if (get_ttyp ()->from_slave)
        ForceCloseHandle1 (get_ttyp ()->from_slave, from_slave);
#endif
      if (get_ttyp ()->from_master)
        CloseHandle (get_ttyp ()->from_master);
      if (get_ttyp ()->to_master)
        CloseHandle (get_ttyp ()->to_master);

      fhandler_tty_common::close ();
[...]

That code closes the last  references to the master end pipes. Those
closed by fhandler_tty_common::close() are just references.

What happens is that although the code wants to make the slave end
encounter an EOF condition it rarely succeeds due to the particular order
of steps involved i.e.:

1) Signal the code for input event

2) Close one set of references to the master end pipes

3) Close the last set of references to the master end pipes

It is likely (and it happens most of the time with MC) that by the time
at which the slave ends tries to react on the input notification the
master end pipes are still not closed and it won't notice the EOF event.

The attached patch solves this problem by rearranging the code a bit. It
tries to be non-intrusive. I offer it for discussion and comments. I hope
that my description of the problem and the patch will help to resolve the
issue even if the patch will get rejected in favour of a better one.

Thanks!
---559023410-378740911-1124290315=:1696
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="cygwin-SIGHUP-on-pty-master-close-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0508171751550.1696@mordor>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="cygwin-SIGHUP-on-pty-master-close-fix.patch"
Content-length: 2689

SW5kZXg6IGZoYW5kbGVyX3R0eS5jYw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3R0eS5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTQzDQpkaWZm
IC11IC1wIC1yMS4xNDMgZmhhbmRsZXJfdHR5LmNjDQotLS0gZmhhbmRsZXJf
dHR5LmNjCTUgQXVnIDIwMDUgMTY6MTE6MjEgLTAwMDAJMS4xNDMNCisrKyBm
aGFuZGxlcl90dHkuY2MJMTcgQXVnIDIwMDUgMTQ6Mjc6MzkgLTAwMDANCkBA
IC0xMTk2LDYgKzExOTYsMTAgQEAgZmhhbmRsZXJfdHR5X2NvbW1vbjo6Y2xv
c2UgKCkNCiAgICAgdGVybWlvc19wcmludGYgKCJDbG9zZUhhbmRsZSAoaW5w
dXRfbXV0ZXg8JXA+KSwgJUUiLCBpbnB1dF9tdXRleCk7DQogICBpZiAoIUZv
cmNlQ2xvc2VIYW5kbGUgKG91dHB1dF9tdXRleCkpDQogICAgIHRlcm1pb3Nf
cHJpbnRmICgiQ2xvc2VIYW5kbGUgKG91dHB1dF9tdXRleDwlcD4pLCAlRSIs
IG91dHB1dF9tdXRleCk7DQorICBpZiAoIUZvcmNlQ2xvc2VIYW5kbGUxIChn
ZXRfaGFuZGxlICgpLCBmcm9tX3B0eSkpDQorICAgIHRlcm1pb3NfcHJpbnRm
ICgiQ2xvc2VIYW5kbGUgKGdldF9oYW5kbGUgKCk8JXA+KSwgJUUiLCBnZXRf
aGFuZGxlICgpKTsNCisgIGlmICghRm9yY2VDbG9zZUhhbmRsZTEgKGdldF9v
dXRwdXRfaGFuZGxlICgpLCB0b19wdHkpKQ0KKyAgICB0ZXJtaW9zX3ByaW50
ZiAoIkNsb3NlSGFuZGxlIChnZXRfb3V0cHV0X2hhbmRsZSAoKTwlcD4pLCAl
RSIsIGdldF9vdXRwdXRfaGFuZGxlICgpKTsNCiANCiAgIC8qIFNlbmQgRU9G
IHRvIHNsYXZlcyBpZiBtYXN0ZXIgc2lkZSBpcyBjbG9zZWQgKi8NCiAgIGlm
ICghZ2V0X3R0eXAgKCktPm1hc3Rlcl9hbGl2ZSAoKSkNCkBAIC0xMjA2LDEw
ICsxMjEwLDYgQEAgZmhhbmRsZXJfdHR5X2NvbW1vbjo6Y2xvc2UgKCkNCiAN
CiAgIGlmICghRm9yY2VDbG9zZUhhbmRsZSAoaW5wdXRfYXZhaWxhYmxlX2V2
ZW50KSkNCiAgICAgdGVybWlvc19wcmludGYgKCJDbG9zZUhhbmRsZSAoaW5w
dXRfYXZhaWxhYmxlX2V2ZW50PCVwPiksICVFIiwgaW5wdXRfYXZhaWxhYmxl
X2V2ZW50KTsNCi0gIGlmICghRm9yY2VDbG9zZUhhbmRsZTEgKGdldF9oYW5k
bGUgKCksIGZyb21fcHR5KSkNCi0gICAgdGVybWlvc19wcmludGYgKCJDbG9z
ZUhhbmRsZSAoZ2V0X2hhbmRsZSAoKTwlcD4pLCAlRSIsIGdldF9oYW5kbGUg
KCkpOw0KLSAgaWYgKCFGb3JjZUNsb3NlSGFuZGxlMSAoZ2V0X291dHB1dF9o
YW5kbGUgKCksIHRvX3B0eSkpDQotICAgIHRlcm1pb3NfcHJpbnRmICgiQ2xv
c2VIYW5kbGUgKGdldF9vdXRwdXRfaGFuZGxlICgpPCVwPiksICVFIiwgZ2V0
X291dHB1dF9oYW5kbGUgKCkpOw0KIA0KICAgaWYgKCFoRXhlY2VkKQ0KICAg
ICB7DQpAQCAtMTIyNiw3ICsxMjI2LDYgQEAgZmhhbmRsZXJfcHR5X21hc3Rl
cjo6Y2xvc2UgKCkNCiAgIHdoaWxlIChhY2NlcHRfaW5wdXQgKCkgPiAwKQ0K
ICAgICBjb250aW51ZTsNCiAjZW5kaWYNCi0gIGZoYW5kbGVyX3R0eV9jb21t
b246OmNsb3NlICgpOw0KIA0KICAgaWYgKCFnZXRfdHR5cCAoKS0+bWFzdGVy
X2FsaXZlICgpKQ0KICAgICB7DQpAQCAtMTI0MSw5ICsxMjQwLDE0IEBAIGZo
YW5kbGVyX3B0eV9tYXN0ZXI6OmNsb3NlICgpDQogCUNsb3NlSGFuZGxlIChn
ZXRfdHR5cCAoKS0+ZnJvbV9tYXN0ZXIpOw0KICAgICAgIGlmIChnZXRfdHR5
cCAoKS0+dG9fbWFzdGVyKQ0KIAlDbG9zZUhhbmRsZSAoZ2V0X3R0eXAgKCkt
PnRvX21hc3Rlcik7DQorDQorICAgICAgZmhhbmRsZXJfdHR5X2NvbW1vbjo6
Y2xvc2UgKCk7DQorDQogICAgICAgaWYgKCFoRXhlY2VkKQ0KIAlnZXRfdHR5
cCAoKS0+aW5pdCAoKTsNCiAgICAgfQ0KKyAgZWxzZQ0KKyAgICBmaGFuZGxl
cl90dHlfY29tbW9uOjpjbG9zZSAoKTsNCiANCiAgIHJldHVybiAwOw0KIH0N
Cg==

---559023410-378740911-1124290315=:1696--
