Return-Path: <cygwin-patches-return-2458-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11148 invoked by alias); 18 Jun 2002 16:11:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11133 invoked from network); 18 Jun 2002 16:11:11 -0000
Message-ID: <3D0F5CB6.58140BD3@ieee.org>
Date: Tue, 18 Jun 2002 09:11:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin() patch is in
References: <20020616051506.GA6188@redhat.com> <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com> <3.0.5.32.20020617224247.007faad0@mail.attbi.com> <20020618134102.A23980@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00441.txt.bz2

Corinna Vinschen wrote:

> What exactly did you try?  My intention was to eliminate a
> network access in case Cygwin is started on the Windows
> desktop.  No setuid() is involved.  So the user information
> is the one of the currently locally logged in user.  This
> information should be available on the local machine even
> in case of domain accounts.

I have both a local and a domain account with the same name. 
When the server is NULL, NetUserGetInfo  gives the local info 
even when I am logged in as a domain user (on NT).

If I unset HOMEPATH in DOS before starting sh, the official
Cygwin sets it incorrectly.

Could somebody with only a domain account try the following 
program? It's quick and dirty, you have to type the logonserver
and user names in the program. Compile with -lnetapi32 .

This would just be curiosity, to see if Windows does any
caching. In the case of setuid we are looking up another user. 
Looking up domain accounts on NULL fails. 

Pierre

#include <windows.h>
#include <stdio.h>
#include <lm.h>

/*  gcc -g netuser.c -lnetapi32 */

main()
{
    /* Type the server and username here here */
    short wserver[] = {'\\','\\','A','D','M','I','N','1',0};
    short wuser[] = {'P','H','U','M','B','L','E','T',0};
    LPUSER_INFO_3 ui = NULL;
    DWORD ret;
    int i;

    /* Try on network */
    ret = NetUserGetInfo (wserver, wuser, 3, (LPBYTE *)&ui);
    printf("Server: ret %ld\n", ret);
    if (!ret) {
	for (i=0; ui->usri3_name[i]; i++)
	    printf("%c", ui->usri3_name[i]);
	printf("\n");
	for (i=0; ui->usri3_full_name[i]; i++)
	    printf("%c", ui->usri3_full_name[i]);
	printf("\n");
	for (i=0; ui->usri3_home_dir[i]; i++)
	    printf("%c", ui->usri3_home_dir[i]);
	printf("\n");
    }
    /* Try locally */
    ret = NetUserGetInfo (NULL, wuser, 3, (LPBYTE *)&ui);
    printf("NULL: ret %ld\n", ret);
    if (!ret) {
	for (i=0; ui->usri3_name[i]; i++)
	    printf("%c", ui->usri3_name[i]);
	printf("\n");
	for (i=0; ui->usri3_full_name[i]; i++)
	    printf("%c", ui->usri3_full_name[i]);
	printf("\n");
	for (i=0; ui->usri3_home_dir[i]; i++)
	    printf("%c", ui->usri3_home_dir[i]);
	printf("\n");
    }
}
