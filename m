Return-Path: <SRS0=dZKr=3O=kmaps.co=evgeny@sourceware.org>
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by sourceware.org (Postfix) with ESMTPS id B7D513858D1E
	for <cygwin-patches@cygwin.com>; Wed,  3 Sep 2025 17:42:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7D513858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B7D513858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::136
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1756921325; cv=none;
	b=jE2723pq4xjdrQiHn5n8F8jdVPNihUhbNUvhgqY39Bpt4k9xlKR1g7JOX3+rnNqR3LAGJr2vpwEuiBWx7n3jk+nuzgrvkDcIsT3IukMrJVJ07mFrzuVko19qXndBvTm811/McSyOM/G3mYGXU5Pr6XIZbwcEsey4uTO9HSbg0Pc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756921325; c=relaxed/simple;
	bh=pFkKczSG/4CSUKumGWoRBtAA12oiBNGf5F+In955VgM=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=wJm3qVUvcDENtFF4OMUOn85Mv24jMnq3DtzLUHp6KI7oivVWGsU/bB3Rj5ACuFFgN4OotlpFlm6ktjKIkqnqtEC9qSDXA03iG+w4ukTRQeaRWBQd7NI22HeUjI/H/oZ+gKah0O3w5um53eA41hJ6/K2bqhg1vttD73HcsyD1vZY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7D513858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=DtY9SyCi
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3f38bafe6ddso697765ab.1
        for <cygwin-patches@cygwin.com>; Wed, 03 Sep 2025 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1756921324; x=1757526124; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFkKczSG/4CSUKumGWoRBtAA12oiBNGf5F+In955VgM=;
        b=DtY9SyCiOzUQ9YlwaLD6IDuYY0oEER/u9W+039HGEonin7SrNg6ERzocMG1SUPKDFw
         J2zgW2HmAuW4IUUMXySXnatOKdHE6eD2PmBs2R6c0eJz4OBRLZ1AvbTT63DZiIy/dlzL
         GWUYdKl4YGs0+7CxWYXzvYImUmFu9ygiHWbcundJE9Q83ezKUadHwp1sUWH8Uqmn1tC1
         c3M5Nw0TUCXrTcXXNMs/rHk0UdQv8WIqSZlkGt2+IQyUUNsnHeeMUHzjcCJgFNQUEf7K
         ZbRDYyEf2nYGfciMXIMYv1qbA1wgihTQIEyX9IKcnCCR8w5S1zPfomV41RCzbIIJxMfv
         O1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756921324; x=1757526124;
        h=content-transfer-encoding:to:subject:message-id:date:in-reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFkKczSG/4CSUKumGWoRBtAA12oiBNGf5F+In955VgM=;
        b=EtDZrVT3CV97Tyrt6G3zWvn00UGHP/d2KizIIegOtt7mitQbkw0GBfVFWcCD0Y6fqW
         oedcaKFVlXLfZRiG2deSFIA5z9SPDrtTUASztjQS856S7s4Kd4w1VzMEdvXLQraamYyB
         BZ/Pt12EuVe3K3lyg5a0pje+qxaDrq2iT6plEAbz76QL5TB4yTJ1Vs52xD+KKceT1ytX
         QCkb5SH6xo2BvuOc0dttcB36QS8HHk/ZCc+9AmvcknMotmVZMXzfQGFj5ySrNCVojZFM
         NeBcNSwwAte/S4886f2QPO4zbSngVZWl5IRSKRodU4+ijAad3rWNIkr1UdZs5w518TnX
         I3EA==
X-Gm-Message-State: AOJu0YzXLnflpdIcJDgvpcFOMy1qrWlp/bZ9N7uMXAvf0oFiBjY7qbDX
	vwM88IeFFk3un59med0jVm3foRVfBCrjcvFQwOcw+343Td5sv30lo5FftnK3HpTdHnf05Q5dqUw
	x8bJraAjXlGox+i6StrPVBDyVPuIL0MEaHxY6CKsrGgET8H3ev/FZ1CY=
X-Gm-Gg: ASbGncsT5ucDnJabT1vUjzWEO+wCcZPnPQpAxmTbvv5QqhE4QT3IC4cDT6275zw6inV
	l426z4Uv25fa71OH7hRIcp/U2lFSHKbQnKNSCC0EDfXi5l+SYHgDe5kJrIalCmWaVJZon02iA+W
	1+9acFoTJjoJITu+zPd2h7O/mGYyadQi/fkEZhbLGtFtzjaco0kAC4OTJNtLBRziuxtVZ4/4i1p
	9uSTWwB
X-Google-Smtp-Source: AGHT+IEh8t2GjhydHN9cT0dsRtkYml/cnBVglH4IL57kYt4G51xXa39O6SIaaMhytlm+XMEkDIrZfZUa/siBVszNl3I=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:3ef:969c:c91 with SMTP id
 e9e14a558f8ab-3f400097800mr323271325ab.6.1756921324596; Wed, 03 Sep 2025
 10:42:04 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Sep 2025 13:42:03 -0400
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Sep 2025 13:42:03 -0400
From: Evgeny Karpov <evgeny@kmaps.co>
In-Reply-To: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A%40MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 3 Sep 2025 13:42:03 -0400
X-Gm-Features: Ac12FXzfYBKgiZUTrxlpT8k8JkqOkqp8icy_M_HA7beJM9j11QZ7WNY86iGEBSw
Message-ID: <CABd5JDDW=LFQTH2RP_8G70gBK0BfjJxHax1eGvwMmUXLcELT_w@mail.gmail.com>
Subject: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Tue Aug 26 2025
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com> wrote:
> -sqrtl NOSIGFE
> +# On AArch64, long double =3D=3D double, so aliasing sqrtl =E2=86=92 sqr=
t
> +[aarch64] sqrtl =3D sqrt NOSIGFE
> +[!aarch64] sqrtl NOSIGFE

Support for overwrites can provide better flexibility for more advanced
conditions when needed and improve readability.

Changing to ...

sqrtl NOSIGFE
+# On AArch64, long double =3D=3D double, so aliasing sqrtl =E2=86=92 sqrt
+[aarch64] sqrtl =3D sqrt NOSIGFE

Regards,
Evgeny
