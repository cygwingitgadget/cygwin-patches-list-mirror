Return-Path: <cygwin-patches-return-3451-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16098 invoked by alias); 22 Jan 2003 07:36:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16088 invoked from network); 22 Jan 2003 07:36:14 -0000
Message-ID: <000a01c2c1e8$ef1a0af0$6501a8c0@tcurtiss2>
From: "Troy Curtiss" <tcurtiss@qcpi.com>
To: <cygwin-patches@cygwin.com>
Subject: Test case for 230.4Kbps support patches - uncovers errno propagation problem?
Date: Wed, 22 Jan 2003 07:36:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C2C1AE.40441870"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00100.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C2C1AE.40441870
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 751

The attached program ratchets through the bitrates defined in termios.h and
tests a given (as first argument) serial port.  This test will indicate if
tcsetattr() returns an error when invalid bitrates are attempted on a given
serial port (along with perror() to print the error-message associated w/
errno.)

In the event that an invalid bitrate is attempted on a port, two events
should occur.  1)  tcsetattr() should return -1, and 2) errno should be set
to EINVAL.  Event #1 seems to work fine w/ my latest patch, but event #2 is
failing because errno is always set to 0.  Unless I'm doing something wrong,
it appears that errno isn't being propagated back up from the call to
tcsetattr() ... can someone else take a peek at this?  Thanks,

-Troy

------=_NextPart_000_0007_01C2C1AE.40441870
Content-Type: text/plain;
	name="test_serial.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test_serial.c"
Content-length: 2470

/* Test all POSIX defined bitrates on a given serial port */

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <errno.h>

typedef struct
{
    speed_t s;
    int speed;
} speedlist_t;

speedlist_t speedlist[] =3D {
    {B0,0},{B50,50},{B75,75},{B110,110}, {B134,134}, {B150,150},=20
    {B200,200}, {B300,300}, {B600,600}, {B1200,1200},{B1800,1800},
    {B2400,2400},{B4800,4800},{B9600,9600},{B19200,19200},{B38400,38400},
    {B57600,57600},{B115200,115200},{B128000,128000},
#ifdef B230400
    {B230400,230400},
#endif
    {B256000,256000}
};

int main(int argc,char **argv)
{
    struct termios dcb;
    int fd,i;

    if (argc !=3D 2)
    {
        fprintf(stderr,"Usage: %s serial_port_name\n",argv[0]);
        return(1);=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
    }

    // Try opening the port (and validate its tty status)
    if ((fd =3D open(argv[1],O_RDWR|O_NOCTTY|O_NONBLOCK)) !=3D -1)
    {
        if (isatty(fd))
        {
            fprintf(stderr,"Testing all POSIX bitrates for port: %s\n",argv=
[1]);
            // Grab the existing DCB/termios parameters (to be safe)
            if (tcgetattr(fd,&dcb) =3D=3D -1)
            {
                perror("Can't get port settings");
                close(fd);
                return(1);
            }
            // 8N1, raw access
            dcb.c_cflag =3D CLOCAL|CS8|CREAD;
            // No min # chars
            dcb.c_cc[VMIN] =3D 0;
            // No max timeout
            dcb.c_cc[VTIME] =3D 0;
            // No postprocessing
            dcb.c_oflag =3D dcb.c_iflag =3D dcb.c_lflag =3D 0;
            // iterate through all POSIX-defined bitrates
            for (i=3D0;i<(sizeof(speedlist)/sizeof(speedlist_t));i++)
            {
                dcb.c_ispeed =3D dcb.c_ospeed =3D speedlist[i].s;
                fprintf(stderr,"Trying %u bps    \t: ",speedlist[i].speed);
                // Make the DCB/termios settings effective and report error=
/success
                if (tcsetattr(fd, TCSANOW, &dcb) < 0) perror("Can't set por=
t settings");
                else fprintf(stderr,"Success\n");
            }
        } else
        {
            perror("Port isn't a serial port");
            close(fd);
            return(1);
        }
    } else
    {
        perror("Can't open port");
        return(1);
    }
    // Close up and exit cleanly
    close(fd);
    return(0);
}

------=_NextPart_000_0007_01C2C1AE.40441870--
