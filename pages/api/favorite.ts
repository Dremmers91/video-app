import { NextApiRequest, NextApiResponse } from "next";
import { without } from "lodash";
import prismadb from "@/lib/prismadb";
import serverAuth from "@/lib/serverAuth";

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse
) {
    try {

    } catch (error) {
        if (error instanceof Error) {
            return res.status(400).json({ error: error.message });
        }
        return res.status(400).end();
    }
}