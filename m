Return-Path: <cygwin-patches-return-4147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26264 invoked by alias); 30 Aug 2003 20:32:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26248 invoked from network); 30 Aug 2003 20:32:48 -0000
Date: Sat, 30 Aug 2003 20:32:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030830203246.GA19303@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <20030829031256.GA18890@redhat.com> <3F4F60EA.4DBB8A51@phumblet.no-ip.org> <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00163.txt.bz2


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 2404

On Sat, Aug 30, 2003 at 03:22:07PM -0400, Pierre A. Humblet wrote:
>At 11:55 AM 8/29/2003 -0400, you wrote:
>>On Fri, Aug 29, 2003 at 10:19:22AM -0400, Pierre A. Humblet wrote:
>>>Christopher Faylor wrote:
>>>>I was heartened to see that zsh did not crash when I sicc'ed this
>>>>program on it -- until I tried to type something at the zsh prompt and
>>>>saw that it was hung.  The reason was that the recursive signal call
>>>>stuff was still not right.  We were restoring the return address
>>>>incorrectly.  AFAICT, we really do have to use the stored
>>>>retaddr_on_stack to rectify setup_handler's inappropriate "fixup" of
>>>>the return address.  Restoring it to 36(%%esp) wasn't right.
>>>
>>>Wow.  What was wrong?  After you noticed that one could remove
>>>movl    %%esp,%%ebp
>>>addl    $36,%%ebp
>>>before the call to set_process_mask, I though eveything made perfect
>>>sense.  After returning from the (user) signal handler and pulling off
>>>the argument, both the esp and ebp should be exactly as before the
>>>call.  It that's not true, the whole stack model of programming breaks
>>>down.
>>
>>The code that was there put the return address of the nested call onto the
>>stack for the return of the initial signal handler.  I just changed it
>>to mimic what call_signal_handler_now does.
>
>FWIW, I have identified the error in my reasoning.
>I was assuming the return address from the initial handler to be 
>"interruptible" (makes sense, otherwise the handler shouldn't have started
>there...).
>
>When it is, retaddr_on_stack is identical to esp + 36 and the code was
>OK.
>
>However there is one case where it is not: when the handler is called
>by sigframe::call_signal_handler from sig_dispatch_pending.

retaddr_on_stack is not always going to be identical to esp + 36 no
matter where it comes from.  I modified my test program to tickle the
previous problem.  I've included it below.  You can short circuit the
sig_dispatch_pending functioni and it will still report different
retaddr_on_stack values -- as it should.  kill is getting called from
different stack depths.

I didn't notice this before since the SIGHUP signal is masked in
'ouch()' function so a call to ouch() wouldn't be made until the mask
was removed.  Changing the code to call another, unmasked signal, whose
handler is dispatched immediately, shows (in the debugger) that
retaddr_on_stack is different.

cgf

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="killit.c"
Content-length: 836

#include <stdio.h>
#include <sys/signal.h>

static int counter = 0;
static int killed = 0;

int killit ()
{
  killed++;
  return kill (getpid (), (killed & 1) ? SIGUSR1 : SIGHUP);
}

int killit0 ()
{
  return killit ();
}

int ouch (int sig)
{
  int real_counter = counter & ~0x400000;
  int recursed = real_counter & counter;
  counter = real_counter;
  if ((++counter & 1) || (counter < 10))
    killit0 ();
  printf ("sig %d, counter %d%s\n", sig, counter, recursed ? ", recursed" : "");
  sig = 27;
  counter |= 0x400000;
}

int bye (int sig)
{
  printf ("sig %d, kill counter %d, counter %d\n", sig, killed, counter);
  exit (0);
}

int
main (int argc, char **argv)
{
  signal (SIGHUP, ouch);
  signal (SIGUSR1, ouch);
  signal (SIGINT, bye);
  while (killit () == 0)
    {
      counter &= ~0x400000;
      puts ("sent");
    }
}

--2fHTh5uZTiUOsy+g--
