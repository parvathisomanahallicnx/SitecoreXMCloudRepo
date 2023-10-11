import type { NextApiRequest, NextApiResponse } from 'next';
import { Customer, Product } from 'commerce-sdk';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' });
  }
  try {
    const clientConfig = {
      headers: {
        authorization: ``,
      },
      parameters: {
        clientId: process.env.SFDC_CLIENT_ID,
        secret: process.env.SFDC_SECRET,
        organizationId: process.env.SFDC_ORGANIZATIONID,
        shortCode: process.env.SFDC_SHORTCODE,
        siteId: process.env.SFDC_SITEID,
      },
    };

    const credentials = `${clientConfig.parameters.clientId}:${clientConfig.parameters.secret}`;
    const base64data = Buffer.from(credentials).toString('base64');
    const headers = { Authorization: `Basic ${base64data}` };
    const client = new Customer.ShopperLogin(clientConfig);

    const shopperToken = await client.getAccessToken({
      headers,
      body: {
        grant_type: 'client_credentials',
      },
    });

    const configWithAuth = {
      ...clientConfig,
      headers: { authorization: `Bearer ${shopperToken.access_token}` },
    };
    let product: any = [];
    const productId = JSON.parse(JSON.stringify(req.body));
    const productsClient = new Product.ShopperProducts(configWithAuth);

    product = await productsClient.getProduct({
      parameters: {
        organizationId: clientConfig.parameters.organizationId,
        siteId: clientConfig.parameters.siteId,
        id: productId,
      },
    });
    if (product.id !== null && product !== null) {
      res.status(200).json({
        Product: product,
      });
    } else {
      res.status(400).json('Having Issue');
    }
  } catch (err) {
    res.status(400).json({ message: 'Something went wrong' + err });
  }
}
