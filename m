Return-Path: <cygwin-patches-return-9705-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96184 invoked by alias); 20 Sep 2019 02:22:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96171 invoked by uid 89); 20 Sep 2019 02:22:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800098.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.98) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 02:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=P8NdwD8O4bZWrwSRjh8kDScm3K+1knRbMYJJldGJtbsR3sywEP/nbgOQyZS+XwoWU6XE3b6WmmUZxlA7qcaPftwrFIPwVWYIhIxnnVkeOPbuTBuJP/yMdq2AiZCnrFOg3mZhTRtsW7VhvwZ7qPdD2GbPi4W+SU8HYDJW8/i4BKobGamcMGyUWFrpZH1tqHlHXHMe2rUyrG8SexV7ZPOg2NNqF9TWpqZ1za+EBPTj18PgDcWo1+xIOJ6NieIWv39n6Sd2boRb27KUFenZu3hJe4WCGPZKFy/1xiOzJ9WXVitvzZd2XpDEQHjjQATfvqf/3mkX+1enYuyasBdnlhTskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=TCp7G0CoxIC032lBRKnBjDl1C/gwnYWQinVx0eLRRxA=; b=ihrE4zEw6yzg4X5TZstXUuUrfPeGd23lfKqeA+rYmz7sRDxTwETUVBWhDZiTH/MqEgDb4/yibM8fGHVu1ujh7PtnEKM71eFc2LdHU3DYUoTZrjAL1WGAuZHLe90pFlEC6W7/rnGtVAimequdD5Na3eZo+FSUULWOO+jAXY5PJiYyaJwM1+rDybQPgNM3DRQj3oyJ+WFME7HWK4N67q8hAEDg/qDZ5J3R+c7904tWNjffR0NyNhln7bbGmh4SPKukZ2Km8VHCRCzJbDu9ndcobHmzztTELtZu2hX9UA/MZTb1Cyvp5UD5neLrHAUszC+HHGGMAU57BTfB1xKQBCZ7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=TCp7G0CoxIC032lBRKnBjDl1C/gwnYWQinVx0eLRRxA=; b=Tut8avKheb/O9CF2lyP+I6l7iTnfw9LcspG3NV4LSLU5951Boe69ym/eC8v1vuZwWQV0aJUnMr+YCD/177A0n50OV6QwdWb7+bxZFwksE0jVPfXNNdozoI+Az9iNCURZwrRyysL4s6nCQY7OZzgeHCd/5NtrpUVxRvi6UccKipo=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6528.namprd04.prod.outlook.com (20.179.227.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22; Fri, 20 Sep 2019 02:21:56 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019 02:21:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 1/1] Cygwin: console: Revive Win7 compatibility.
Date: Fri, 20 Sep 2019 02:22:00 -0000
Message-ID: <5ff6b2d0-7592-7e53-63f1-dcce250b6ad2@cornell.edu>
References: <20190918204955.2131-1-takashi.yano@nifty.ne.jp> <20190918204955.2131-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918204955.2131-2-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:820;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C146E3BC629E25408EB57BEE71D43BFA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QP4cX5fWu20kLjFhMf1Q+6x4LvE0yeFBmKiKFucacq+2rHeuo7PdY+UPRKC9e6Xz8mW7v8YJUssXWAal1nExFQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00225.txt.bz2

On 9/18/2019 4:49 PM, Takashi Yano wrote:
> - The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
>    compatibility. This patch fixes the issue.
> ---
>   winsup/cygwin/fhandler.h          | 6 ++++++
>   winsup/cygwin/fhandler_console.cc | 6 ------
>   winsup/cygwin/select.cc           | 1 -
>   3 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 4efb6a4f2..94b0e520b 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -43,6 +43,12 @@ details. */
>=20=20=20
>   #define O_TMPFILE_FILE_ATTRS (FILE_ATTRIBUTE_TEMPORARY | FILE_ATTRIBUTE=
_HIDDEN)
>=20=20=20
> +/* Buffer size for ReadConsoleInput() and PeakConsoleInput(). */
                                               Peek
> +/* Per MSDN, max size of buffer required is below 64K. */
> +/* (65536 / sizeof (INPUT_RECORD)) is 3276, however,
> +   ERROR_NOT_ENOUGH_MEMORY occurs in win7 if this value is used. */
> +#define INREC_SIZE 2048
> +
>   extern const char *windows_device_names[];
>   extern struct __cygwin_perfile *perfile_table;
>   #define __fmode (*(user_data->fmode_ptr))
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 709b8255d..86c39db25 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -499,9 +499,6 @@ fhandler_console::process_input_message (void)
>=20=20=20
>     termios *ti =3D &(get_ttyp ()->ti);
>=20=20=20
> -	  /* Per MSDN, max size of buffer required is below 64K. */
> -#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
> -
>     fhandler_console::input_states stat =3D input_processing;
>     DWORD total_read, i;
>     INPUT_RECORD input_rec[INREC_SIZE];
> @@ -1165,9 +1162,6 @@ fhandler_console::ioctl (unsigned int cmd, void *ar=
g)
>   	return -1;
>         case FIONREAD:
>   	{
> -	  /* Per MSDN, max size of buffer required is below 64K. */
> -#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
> -
>   	  DWORD n;
>   	  int ret =3D 0;
>   	  INPUT_RECORD inp[INREC_SIZE];
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index ed8c98d1c..e7014422b 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1209,7 +1209,6 @@ peek_pty_slave (select_record *s, bool from_select)
>   	{
>   	  if (ptys->is_line_input ())
>   	    {
> -#define INREC_SIZE (65536 / sizeof (INPUT_RECORD))
>   	      INPUT_RECORD inp[INREC_SIZE];
>   	      DWORD n;
>   	      PeekConsoleInput (ptys->get_handle (), inp, INREC_SIZE, &n);

Pushed, with the above typo corrected.  Thanks.

Ken
