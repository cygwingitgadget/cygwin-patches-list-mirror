Return-Path: <SRS0=KO2Y=B2=gmail.com=philcerf@sourceware.org>
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by sourceware.org (Postfix) with ESMTPS id D2432385734D
	for <cygwin-patches@cygwin.com>; Tue,  6 Jun 2023 15:17:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D2432385734D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53202149ae2so3629961a12.3
        for <cygwin-patches@cygwin.com>; Tue, 06 Jun 2023 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686064666; x=1688656666;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myhoSITgxQbbYPcF7x0/DsSmPIH8Z+9Fq/NDcF75yYQ=;
        b=HTNeS+uY9hdtVkCr7XxtQ8mF5AA0SDiA6UbDS3sbxsLU7QZVi0YKrVQYNBmU7W1HkX
         As6iDfh8kc8HuIgebLTrlG5T8lEkApQWdHUVezxAcXagYemb2UHmhQtDs4Cp58NMhrG9
         7442P+703c/uzPlWGhG599wnQ2RfPxOeUn7QLpT8T5f0HxaiRjxjIQ5GO31Sb/WlNdur
         bR7G2x1FymPe2G6xgw/B9qWSnEu6fH71DdrLKegvoUCv5otntBGbwiNP31VvfTgomYw9
         i8os623nHj6d6QCi+fl9MJUCSAQAFJMFG0NGR3yXy3LEZRcEVdQ9mVrLiM3VAW0G53T4
         UPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686064666; x=1688656666;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myhoSITgxQbbYPcF7x0/DsSmPIH8Z+9Fq/NDcF75yYQ=;
        b=A/qqirk1v42qbBhPAWuXqCrNntmVrDsmv0IHkdp7w1aCLKkBTMsWfW9SeyBLX9Pv7R
         LT9xD5wCFFLkepLqgXMcRbJO9TUAc8pO2y2eGjFc/WE2PLhLqnYz09EFzC50rheBLULm
         ptYocSPL4nCGdFkNRtgE1f1cEASMnvKzwUf04x+syzfm/JVuuxrTPuICaQBk0zHfOPY7
         t9R3oyk6FkvO+KV54r8VDyY/v4+cHwBd4T1zLsP63nDTKGOZQ66atAdmPeaAZWhuLXqu
         wFREoA58S4j7VRZLqYFHkNRh4atn+jvr4EtsmxrL/oyy46mIkI4Z4iNdwUQ3jnVWp2b3
         wShQ==
X-Gm-Message-State: AC+VfDyg7U2lratijVS+TIQYqK/hhT0BLt5PDBJ3xwbAmy6cMdRYrZf5
	FUkrKGYOiQlhjJ9ixkh+6yQ3oGq8jciSrLD7Pv/oVNLECug=
X-Google-Smtp-Source: ACHHUZ5BRepphbrNstGAhObbtNX6kLlqUnE/47kSoqDg4IveDJhNCtI6Hs7rqfWSsO5psRZ/UfQRC1BnsxpuIeuPVUA=
X-Received: by 2002:a17:902:c3c4:b0:1ae:7421:82b5 with SMTP id
 j4-20020a170902c3c400b001ae742182b5mr1482566plj.45.1686064665717; Tue, 06 Jun
 2023 08:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca> <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com> <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
In-Reply-To: <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
From: Philippe Cerfon <philcerf@gmail.com>
Date: Tue, 6 Jun 2023 17:17:34 +0200
Message-ID: <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, Jun 6, 2023 at 3:28=E2=80=AFPM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Yes, it is wrong, because the value of MAX_EA_NAME_LEN / XATTR_NAME_MAX
> is used for array size definitions as well as comparisons.

Do you prefer to keep MAX_EA_NAME_LEN and just have that set like,
perhaps with an additional comment that explains it:
   #define MAX_EA_NAME_LEN    (XATTR_NAME_MAX + 1 - strlen("user."))
or rather inline all that without any MAX_EA_NAME_LEN?

I think at least GCC and CLANG should be smart enough to optimise the
strlen() on a static string.

Regards,
Philippe
