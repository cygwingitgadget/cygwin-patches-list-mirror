Return-Path: <cygwin-patches-return-2752-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15122 invoked by alias); 31 Jul 2002 01:21:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15059 invoked from network); 31 Jul 2002 01:21:14 -0000
Date: Tue, 30 Jul 2002 18:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Performance: fhandler_socket and ready_for_read()
Message-ID: <20020731012133.GB21134@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com> <086701c2382f$2c6b19b0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086701c2382f$2c6b19b0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00200.txt.bz2

On Wed, Jul 31, 2002 at 02:11:16AM +0100, Conrad Scott wrote:
>"Christopher Faylor" <cgf@redhat.com> wrote:
>> Unless you disagree, would you mind just adding a
>> get_r_no_interrupt method to fhandler_socket,
>> using the same criteria as your ready_for_read stub?
>
>No disagreement there, that's cleaner.  See attached for a new
>patch.
>
>> Thanks for finding this, by the way.  A speed improvement in
>> socket handling is very welcome.
>
>Thanks.  And yes, after this patch cygserver with sockets is still
>not as quick as with named pipes, but it's made up a lot of
>ground.
>
>> Sounds like it is time for a 1.3.13 release.
>
>Ominous numbers those . . .  I'm just glad I'm not superstitious
>:-)

If it helps, I was born on Friday the 13.  So this might be a lucky
number.

>+bool
>+fhandler_socket::get_r_no_interrupt ()
>+{
>+  if (!is_nonblocking () && winsock2_active)
>+    return true;
>+  else
>+    return fhandler_base::get_r_no_interrupt ();
>+}
>+
> void
> fhandler_socket::set_connect_secret ()
> {

Maybe I'm missing something but I don't think it has to be this complicated.
I think this should just be basically:

bool
fhandler_socket::get_r_no_interrupt ()
{
  return winsock2_active;
}

You don't have to worry about non_blocking or returning the base class
because you know that it is not intended to be called for the non_blocking
case and you know that sockets are "slow" devices.  So I think this should
only be gated on whether we're lucky enough to be using winsock2.

cgf
