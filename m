From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: readlink() patch
Date: Tue, 05 Sep 2000 09:10:00 -0000
Message-id: <200009051610.MAA14632@envy.delorie.com>
References: <119170270886.20000903213328@logos-m.ru> <20000903200337.A22931@cygnus.com> <33215577994.20000904100834@logos-m.ru>
X-SW-Source: 2000-q3/msg00064.html

Has anyone actually *tried* readlink() on linux?  I did.

If the result is too long, it is silently truncated to fit the buffer,
and no error is returned.

main(int argc, char **argv)
{
  int i;
  char buf[20];
  memset (buf, 0, sizeof(buf));
  i = readlink (argv[1], buf, 1);
  printf ("ret %d `%s'\n", i, buf);
  perror ("errno");
}
