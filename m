Return-Path: <cygwin-patches-return-3104-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22871 invoked by alias); 4 Nov 2002 01:09:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22823 invoked from network); 4 Nov 2002 01:09:58 -0000
Date: Sun, 03 Nov 2002 17:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty patch
Message-ID: <20021104011150.GA23246@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002701c28394$ce2fc1f0$0201a8c0@sos> <20021104003759.GA22976@redhat.com> <003c01c2839c$355bf130$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003c01c2839c$355bf130$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00055.txt.bz2

On Sun, Nov 03, 2002 at 07:50:42PM -0500, Sergey Okhapkin wrote:
>
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Sunday, November 03, 2002 7:37 PM
>Subject: Re: fhandler_tty patch
>
>> > * fhandler_tty.cc (fhandler_tty_slave::ioctl): Do nothing if the new
>> > window size is equal to the old one.  Send SIGWINCH if slave connected
>> > to a pseudo tty.
>> > (fhandler_pty_master::ioctl): Do nothing if the new window size is
>> > equal to the old one.
>>
>> Is this according to some standard?  It seems like we're sending too many
>> SIGWINCHes with your patch.
>>
>
>Without the patch we're not sending SIGWINCH at all. ioctl(tty, TIOSWINSZ,
>...) supposed to send SIGWINCH if the window size changed. The ioctl() call
>should work in the same way for both master and slave ends of pseudo tty,
>without the patch the ioctl works for master end only, but many unix
>programs (screen for example) change the window size of the slave end.

Ok.  I haven't looked closely at this code before.  I just am not sure
what use setting the size on a pty master would entail.  I wonder if it
is supposed to be propagated to the slave.  Also, isn't the master
supposed to be notified of size changes in the slave?

I'll apply the patch but I suspect that this is still not exactly right
wrt UNIX emulation.

cgf
