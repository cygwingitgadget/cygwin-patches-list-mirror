From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: einval-on-wrong-args patch
Date: Fri, 16 Feb 2001 09:53:00 -0000
Message-id: <19294003970.20010216205019@logos-m.ru>
References: <12986060127.20010216183755@logos-m.ru> <20010216120709.B19422@redhat.com>
X-SW-Source: 2001-q1/msg00082.html

Hi!

Friday, 16 February, 2001 Christopher Faylor cgf@redhat.com wrote:

>>  return  EINVAL  if  signal()  or  lseek()  are  called  with illegal
>>arguments.

CF> Either your signal() change is not quite right, or sigaction() is wrong.
CF> sigaction() allows setting the handler for SIGKILL to SIG_DFL.  Is
CF> that incorrect?  If not, then please modify your change (and check it in).
CF> If it is the incorrect behavior, could you fix sigaction, too?

SUSv2 is a bit vague on the subject, but this program

#include <stdio.h>
#include <signal.h>

main ()
{
  struct sigaction act;
  act.sa_handler = SIG_DFL;
  act.sa_flags = 0;
  act.sa_sigaction = NULL;
  sigemptyset ( &act.sa_mask );
  if ( signal ( SIGKILL, SIG_DFL ) == SIG_ERR ) perror ("signal" );
  if ( sigaction ( SIGKILL, NULL, NULL ) ) perror ( "sigaction1" );
  if ( sigaction ( SIGKILL, &act, NULL ) ) perror ( "sigaction2" );
}

when run on linux, prints

signal: Invalid argument
sigaction2: Invalid argument

so  perhaps sigaction should be fixed. moreover, SUSv2 says that if we
add SIGKILL or SIGSTOP to sa_mask, this should be silently ignored.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

