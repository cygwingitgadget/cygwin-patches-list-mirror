Return-Path: <cygwin-patches-return-2648-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15533 invoked by alias); 14 Jul 2002 18:35:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15519 invoked from network); 14 Jul 2002 18:35:32 -0000
Message-ID: <005e01c22b65$89eb0f90$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <002a01c22b2f$07f9bda0$6132bc3e@BABEL> <20020714161750.GA26964@redhat.com>
Subject: Re: Protect handle issue-ettes
Date: Sun, 14 Jul 2002 11:35:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005B_01C22B6D.EB67C030"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00096.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_005B_01C22B6D.EB67C030
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 448

Chris,

I've just written a little test program for fcntl(..., FD_CLOEXEC)
and it doesn't seem to be having any effect at all, i.e. the
exec'd program can happily read from a file descriptor it's parent
open'd and marked as close-on-exec.  So something's awry
somewhere.

I've attached the test program (in case I've made a hash of it):
call it as ./clexec_exec -1 and it should print out a chunk of
/etc/passwd (from the exec'd copy).

// Conrad


------=_NextPart_000_005B_01C22B6D.EB67C030
Content-Type: application/octet-stream;
	name="clexec_exec.cc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="clexec_exec.cc"
Content-length: 1552

#include <sys/types.h>=0A=
#include <sys/stat.h>=0A=
#include <sys/wait.h>=0A=
=0A=
#include <fcntl.h>=0A=
#include <stdio.h>=0A=
#include <stdlib.h>=0A=
#include <unistd.h>=0A=
=0A=
int=0A=
main (const int argc, char *argv[], char *envp[])=0A=
{=0A=
  if (argc !=3D 2)=0A=
    {=0A=
      fprintf (stderr, "Usage: %s -1\n", argv[0]);=0A=
      exit (1);=0A=
    }=0A=
=0A=
  const int flag =3D atoi (argv[1]);=0A=
=0A=
  if (flag =3D=3D -1)=0A=
    {=0A=
      const int fd =3D open ("/etc/passwd", O_RDONLY);=0A=
=0A=
      if (fd =3D=3D -1)=0A=
	{=0A=
	  perror ("/etc/passwd");=0A=
	  exit (1);=0A=
	}=0A=
=0A=
      if (fcntl (fd, F_SETFD, FD_CLOEXEC) =3D=3D -1)=0A=
	{=0A=
	  perror ("fcntl");=0A=
	  exit (1);=0A=
	}=0A=
=0A=
      pid_t pid =3D fork ();=0A=
=0A=
      switch (pid)=0A=
	{=0A=
	case -1:=0A=
	  perror ("fork");=0A=
	  exit (1);=0A=
=0A=
	case 0:                     // child=0A=
	  {=0A=
	    char buf[BUFSIZ];=0A=
	    sprintf (buf, "%d", fd);=0A=
	    argv[1] =3D buf;=0A=
	    execve (argv[0], argv, envp);=0A=
	  }=0A=
	  break;=0A=
=0A=
	default:                    // parent=0A=
	  {=0A=
	    int status;=0A=
	    if (wait (&status) =3D=3D -1)=0A=
	      {=0A=
		perror ("wait ()");=0A=
		exit (1);=0A=
	      }=0A=
	  }=0A=
	  break;=0A=
	}=0A=
    }=0A=
  else=0A=
    {=0A=
      char buf[BUFSIZ];=0A=
      ssize_t len =3D read (flag, buf, sizeof (buf));=0A=
      if (len =3D=3D -1)=0A=
	{=0A=
	  perror ("/etc/passwd");=0A=
	  exit (1);=0A=
	}=0A=
      write (1, buf, len);=0A=
    }=0A=
=0A=
  return 0;=0A=
}=0A=

------=_NextPart_000_005B_01C22B6D.EB67C030--

